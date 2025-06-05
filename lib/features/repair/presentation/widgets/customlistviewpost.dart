import 'package:car_mate/features/repair/data/models/get_all_posts_model.dart';
import 'package:car_mate/features/repair/data/repo/get_all_posts_repo.dart';
import 'package:car_mate/features/repair/presentation/widgets/custompost.dart';
import 'package:flutter/material.dart';

class CustomListViewPosts extends StatelessWidget {
  const CustomListViewPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final GetAllPostsRepository postRepository = GetAllPostsRepository();
    return Expanded(
      child: FutureBuilder<List<GetAllPostsModel>>(
        future: postRepository.getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Failed to load posts: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found'));
          }
          List<GetAllPostsModel> reversedItems =
              snapshot.data!.reversed.toList();
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                CustomPost(post: reversedItems[index]),
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}
