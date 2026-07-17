import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/utils/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text('Simple Blog'),
        ),
        backgroundColor: AppColors.primary.color,
      ),
      drawer: SideBar(),
      body: Column(children: const [Expanded(child: PostsView())]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.portrait), label: 'Guest'),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {},
      ),
      backgroundColor: AppColors.bg.color,
    );
  }
}

/// TODO(homusys): Do something about the sidebar.
class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(backgroundColor: AppColors.primary.color);
  }
}

/// The PostsView is a class that will contain all of the posts from the
/// database.
class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [for (var i = 0; i < 20; ++i) PostItem()]);
  }
}

/// The PostItem is a class that represents a user post. The post consists of a
/// title headeing, an optional image, the content of the post, a like button
/// and a comment button. If the user currently logged in is the original
/// poster, then the post can be edited by that user. Otherwise, the current
/// user is only able to read and react the post.
class PostItem extends StatefulWidget {
  const PostItem({super.key});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Widget createPostHeader(String username) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 25, 25, 212)),
        ),
        Container(child: Text(username)),
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
    Widget likeButton = createPostActions(() {}, Icons.thumb_up_outlined);
    Widget commentButton = createPostActions(() {}, Icons.chat_bubble);

    return Row(children: [likeButton, commentButton]);
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

  String _user = 'User';
  String _title = 'Placeholder Title';
  String _imageSrc = 'Sample Image';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 1, 4, 0),
      child: GestureDetector(
        onTap: () {
          print("Clicked");
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
            color: Color.fromARGB(255, 209, 210, 247),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createPostHeader(_user),
              createPostBody(_title, _imageSrc),
              createPostActionsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

/// TODO(homusys): Create the structure of a simple post and its comments.
/// The post is something clickable and pushes another view on the stack so
/// that the user is able to view the content and all the comments.
