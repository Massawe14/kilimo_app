import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/drawer/drawer.dart';
import '../../../../common/widgets/pop_up_menu/popup_menu.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/post/post_repository.dart';
import '../../../../util/constants/colors.dart';
import '../../../../util/constants/sizes.dart';
import '../../models/community/post_modal.dart';
import 'ask_community_screen.dart';
import 'widgets/crop_categories.dart';
import 'widgets/post_list.dart';

class CommunityScreen extends StatelessWidget {
  CommunityScreen({super.key});
  
  final PostRepository postRepository = Get.put(PostRepository());
  final TextEditingController _searchController = TextEditingController();
  final RxString _selectedFilter = 'All'.obs; // Initial filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {
              // Handle notification icon action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {
              showPopupMenu(context);
            },
          ),
        ],
      ),
      drawer: const NavigationDrawerMenu(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search Section
            SliverPadding(
              padding: const EdgeInsets.all(TSizes.spaceBtwItems),
              sliver: SliverToBoxAdapter(
                child: TypeAheadField<PostModal>(
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search by crop type or location',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        // Trigger filtering whenever the search text changes
                        _selectedFilter.value = value;
                      },
                    );
                  },
                  suggestionsCallback: (pattern) async {
                    if (pattern.isEmpty) return [];
                    return await postRepository.searchPosts(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion.problemTitle), // Show post title
                      subtitle: Text(suggestion.cropType),   // Show crop type
                    );
                  },
                  onSelected: (suggestion) {
                    _searchController.text = suggestion.problemTitle; // Set the title as search text
                  },
                  emptyBuilder: (context) => const ListTile(
                    title: Text('No results found'),
                  ),
                ),
              ),
            ),
            // Filter Section
            // Crop Filter Dropdown
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter by',
                      style: TextStyle(
                        color: TColors.dark,
                        fontSize: TSizes.fontSizeMd,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        String selectedFilter = _selectedFilter.value;
                        String searchQuery = _searchController.text.trim();

                        if (selectedFilter == 'All' && searchQuery.isEmpty) {
                          postRepository.fetchAllPosts();
                        } else if (selectedFilter == 'All') {
                          postRepository.fetchPostsByLocation(searchQuery);
                        } else {
                          postRepository.fetchFilteredPosts(selectedFilter, searchQuery);
                        }
                      },
                      child: const Text(
                        'Apply Filter',
                        style: TextStyle(
                          color: TColors.accent,
                          fontSize: TSizes.fontSizeMd,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Crop Categories Section
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              sliver: SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TSectionHeading(title: 'Crop categories', showActionButton: false),
                    SizedBox(height: TSizes.spaceBtwItems),
                    CropCategories(),
                  ],
                ),
              ),
            ),
            // Post Section
            SliverPadding(
              padding: const EdgeInsets.all(5),
              sliver: Obx(
                () => TPostList(
                  filter: _selectedFilter.value,
                  searchQuery: _searchController.text,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        onPressed: () => Get.to(() => const AskCommunity()),
        backgroundColor: TColors.accent,
        label: const Text('Ask Community', style: TextStyle(color: TColors.white)),
        icon: const Icon(Iconsax.receipt_edit, color: TColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
