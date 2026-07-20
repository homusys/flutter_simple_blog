import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/users_viewmodel.dart';
import 'package:flutter_simple_blog/views/login_page.dart';
import 'package:flutter_simple_blog/views/register_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget displayBody(UsersViewmodel vm) {
    if (vm.authService.isLoggedIn) {
      return SingleChildScrollView(child: UserProfileBody(vm: vm));
    }
    return GuestProfileBody(vm: vm);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersViewmodel>(
      builder: (context, value, child) => displayBody(value),
    );
  }
}

class GuestProfileBody extends StatelessWidget {
  const GuestProfileBody({super.key, required this.vm});

  final UsersViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            foregroundImage: AssetImage('assets/images/portrait.png'),
            backgroundImage: AssetImage('assets/images/portrait.png'),
          ),
          Text('Guest'),

          /// LOGIN
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Login'),
          ),

          /// SIGNUP
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text('Signup'),
          ),
        ],
      ),
    );
  }
}

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key, required this.vm});

  final UsersViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [ProfilePhoto(), Text('0 POSTS')]),
        TextButton(onPressed: vm.logoutUser, child: Text('Logout')),
      ],
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
