import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/post_model.dart';
import 'package:flutter_simple_blog/viewmodels/posts_viewmodel.dart';
import 'package:flutter_simple_blog/views/post_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: PostsView())]);
  }
}

/// The PostsView is a class that will contain all of the posts from the
/// database.
class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostsViewmodel>(
      builder: (context, value, child) => FutureBuilder(
        future: value.getAllPosts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final posts = snapshot.data!;

          if (posts.isEmpty) {
            return Text('There are no posts.');
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final postItem = posts[index];

              PostModel postModel = PostModel(
                postId: postItem['id'],
                createdAt: postItem['created_at'],
                createdBy: postItem['profiles']['email'],
                title: postItem['title'],
              );

              return PostItem(postModel: postModel);
            },
          );
        },
      ),
    );
  }
}

/// The PostItem is a class that represents a user post. The post consists of a
/// title headeing, an optional image, the content of the post, a like button
/// and a comment button. If the user currently logged in is the original
/// poster, then the post can be edited by that user. Otherwise, the current
/// user is only able to read and react the post.
class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.postModel});

  final PostModel postModel;
  final String _imageSrc = 'Sample Image';

  Widget createPostHeader(String email) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 25, 25, 212)),
        ),
        Text(email),
      ],
    );
  }

  Widget createPostBody(String title, String imageSrc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), Text(imageSrc)],
    );
  }

  Widget createPostActionsContainer() {
    // Widget likeButton = createPostActions(() {}, Icons.thumb_up_outlined);
    Widget commentButton = createPostActions(() {}, Icons.chat_bubble);

    return Row(children: [/*likeButton, */ commentButton]);
  }

  Widget createPostActions(
    void Function()? onPressed,
    IconData? iconData, {
    int count = 0,
  }) {
    return Row(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(iconData)),
        Text('$count'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 1, 12, 0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostPage(postId: postModel.postId),
            ),
          );
        },
        child: Ink(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createPostHeader(postModel.createdBy),
              createPostBody(postModel.title, _imageSrc),
              createPostActionsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
