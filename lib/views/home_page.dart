import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/models/post_model.dart';
import 'package:flutter_simple_blog/viewmodels/home_viewmodel.dart';
import 'package:flutter_simple_blog/views/post_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      /// https://dart.dev/language/operators#cascade-notation
      create: (context) => HomeViewmodel()..getAllPosts(),
      child: Consumer<HomeViewmodel>(
        builder: (context, vm, child) => Column(
          children: [
            Row(
              children: [
                Text('Posts'),
                Spacer(),
                TextButton(
                  onPressed: () {
                    vm.getAllPosts();
                  },
                  child: Text('Refresh'),
                ),
              ],
            ),
            Expanded(child: PostsView(vm: vm)),
          ],
        ),
      ),
    );
  }
}

/// The PostsView is a class that will contain all of the posts from the
/// database.
class PostsView extends StatefulWidget {
  final HomeViewmodel vm;

  const PostsView({super.key, required this.vm});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  // @override
  // void initState() {
  //   /// https://medium.com/@wassimsakri/understanding-widgetsbinding-instance-addpostframecallback-in-flutter-86860d5266ff
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     widget.vm.getAllPosts();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.vm.posts.isEmpty) {
      return Text('There are no posts.');
    }

    return ListView.builder(
      itemCount: widget.vm.posts.length,
      itemBuilder: (context, index) {
        return PostItem(postModel: widget.vm.posts[index]);
      },
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
