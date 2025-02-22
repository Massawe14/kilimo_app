import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../admin_navigation_menu.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
import '../../../features/authentication/screens/signup/signup.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../features/personalization/models/user_modal.dart';
import '../../../user_navigation_menu.dart';
import '../../../util/exceptions/firebase_auth_exceptions.dart';
import '../../../util/exceptions/firebase_exceptions.dart';
import '../../../util/exceptions/format_exceptions.dart';
import '../../../util/exceptions/platform_exceptions.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  // Called from main.dart on app launch
  @override
  void onReady() {
    // Remove the native splash screen
    FlutterNativeSplash.remove();
    // Listen to authentication state changes
    listenToAuthState();
  }

  // Listen to authentication state changes
  void listenToAuthState() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(() => const LoginScreen());
      } else {
        screenRedirect();
      }
    });
  }

  // Function to determine the relevant screen and redirect accordingly
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      await handleAuthenticatedUser(user);
    } else {
      handleUnauthenticatedUser();
    }
  }
  
  // Handle authenticated user
  Future<void> handleAuthenticatedUser(User user) async {
    if (user.emailVerified) {
      await mainMenuNavigation(user);
    } else {
      Get.offAll(() => VerifyEmailScreen(email: user.email));
    }
  }
  
  // Handle unauthenticated user
  void handleUnauthenticatedUser() {
    deviceStorage.writeIfNull('isFirstTime', true);
    if (deviceStorage.read('isFirstTime') != true) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(const OnBoardingScreen());
    }
  }

  // Helper method to redirect based on role
  Future<void> mainMenuNavigation(User user) async {
    final snapshot = await _db.collection('Users').doc(user.uid).get();
    
    if (snapshot.exists) {
      final userModel = UserModal.fromSnapshot(snapshot);
      _redirectBasedOnRole(userModel.userRole);
    } else {
      Get.offAll(() => const SignupScreen());
    }
  }

  // Redirect user based on role
  void _redirectBasedOnRole(String role) {
    switch (role) {
      case 'Farmer':
        Get.offAll(() => const UserNavigationMenu());
        break;
      case 'Extension Officer':
        Get.offAll(() => const AdminNavigationMenu());
        break;
      default:
        Get.offAll(() => const SignupScreen());
    }
  }

  /* ----------------------------- Email & Password sign-in ---------------------- */

  // [EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again.';
    }
  }

  // [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again.';
    }
  }

  // [EmailVerification] - Mail VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again.';
    }
  }

  // [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again.';
    }
  }

  // [ReAuthenticate] - RE AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again.';
    }
  }

  /* ----------------------------- Federated identity & social sign-in --------------- */

  // [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return userCredential
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong, Please try again: $e');
      return null;
    }
  }

  // [FacebookAuthentication] - FACEBOOK

  /* ---------------------------- ./end Federated identity & social sign-in ------------ */

  // [LogoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again.';
    }
  }

  // DELETE USER - Remove user Auth and Firestore Account.
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again.';
    }
  }
}
