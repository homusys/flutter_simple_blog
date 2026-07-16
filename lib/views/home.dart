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
      body: Column(children: const [PostsView()]),
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
    return Container();
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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
