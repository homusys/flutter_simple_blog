import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/users_controller.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersController>(
      builder: (context, value, child) => ListView(
        children: [
          Row(children: [ProfilePhoto(), Text('0 Posts')]),
          TextButton(onPressed: value.logoutUser, child: Text('Log out')),
        ],
      ),
    );
  }
}

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => ProfilePhotoState();
}

class ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        height: 150,
        child: CircleAvatar(
          foregroundImage: AssetImage('assets/images/portrait.png'),
          backgroundImage: AssetImage('assets/images/portrait.png'),
        ),
      ),
    );
  }
}
