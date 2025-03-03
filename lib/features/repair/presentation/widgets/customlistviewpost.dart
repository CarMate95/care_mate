import 'package:car_mate/features/repair/data/models/post_model.dart';
import 'package:car_mate/features/repair/data/repo/post_repo.dart';
import 'package:car_mate/features/repair/presentation/widgets/custompost.dart';
import 'package:flutter/material.dart';

class CustomListViewPosts extends StatelessWidget {
  const CustomListViewPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final PostRepository postRepository = PostRepository();
    return Expanded(
      child: FutureBuilder<List<PostModel>>(
        future: postRepository.getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load posts: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found'));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => CustomPost(post: snapshot.data![index]),
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}
