import 'package:car_mate/features/repair/data/models/post_model.dart';
import 'package:car_mate/features/repair/data/repo/post_repo.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_own_post.dart';
import 'package:flutter/material.dart';

class CustomListViewOwnPosts extends StatelessWidget {
  const CustomListViewOwnPosts({super.key});

  @override
  Widget build(BuildContext context) {
    
    final PostRepository postRepository = PostRepository();
    // final UserRepository userRepository = UserRepository();
    return Expanded(
      child: FutureBuilder<List<PostModel>>(
        future: postRepository.getOwnPosts(),
        builder: (context, postSnapshot) {
          if (postSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (postSnapshot.hasError) {
            return const Center(
                child: Text('Failed to load posts: \${postSnapshot.error}'));
          } else if (!postSnapshot.hasData || postSnapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found'));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => CustomOwnPost(
              post: postSnapshot.data![index],
              // user: userSnapshot.data!,
            ),
            itemCount: postSnapshot.data!.length,
          );
        },
      ),
    );
  }
}
