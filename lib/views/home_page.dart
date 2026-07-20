import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: PostsView())]);
  }
}

/// The PostsView is a class that will contain all of the posts from the
/// database.
class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  final _future = Supabase.instance.client.from('posts').select();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
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
            print(index);
            final postItem = posts[index];

            /// TODO(homus): Change email to actual email
            return PostItem(email: postItem['title'], title: postItem['title']);
          },
        );
      },
    );
  }
}

/// The PostItem is a class that represents a user post. The post consists of a
/// title headeing, an optional image, the content of the post, a like button
/// and a comment button. If the user currently logged in is the original
/// poster, then the post can be edited by that user. Otherwise, the current
/// user is only able to read and react the post.
class PostItem extends StatefulWidget {
  const PostItem({super.key, this.email = '', this.title = 'testtitle'});

  final String email;
  final String title;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  String _imageSrc = 'Sample Image';

  Widget createPostHeader(String email) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 25, 25, 212)),
        ),
        Container(child: Text(email)),
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
      padding: const EdgeInsets.fromLTRB(4, 1, 4, 0),
      child: InkWell(
        onTap: () {
          print("Clicked");
        },
        child: Ink(
          color: Color.fromARGB(255, 225, 199, 199),
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createPostHeader(widget.email),
              createPostBody(widget.title, _imageSrc),
              createPostActionsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

/// TODO(homusys):
/// The post is something clickable and pushes another view on the stack so
/// that the user is able to view the content and all the comments.
