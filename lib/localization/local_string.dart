import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // ENGLISH LANGUAGE
    'en_US': {
      "select_your_language": "Select your language",
      "save": "Save",
      "cancel": "Cancel",
      "choose_a_language": "Choose a language",
      "language": "English",
      "send": "Send",
      "upload_image": "Upload image",
    },
    
    // SWAHILI LANGUAGE
    'sw_TZ': {
      "select_your_language": "Chagua lugha yako",
      "save": "Hifadhi",
      "cancel": "Batilisha",
      "choose_a_language": "Chagua lugha",
      "language": "Swahili",
      "send": "Tuma",
      "upload_image": "Pakia picha",
    }
  };
}
