import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/viewmodels/users_viewmodel.dart';
import 'package:flutter_simple_blog/views/auth/auth_page.dart';
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

  void gotoAuthPage(BuildContext context, AuthFormType authFormType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPage(authFormType: authFormType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfilePhoto(),
          Text('Guest'),

          /// LOGIN
          TextButton(
            onPressed: () => gotoAuthPage(context, AuthFormType.login),
            child: Text('Login'),
          ),

          /// SIGNUP
          TextButton(
            onPressed: () => gotoAuthPage(context, AuthFormType.signup),
            child: Text('Signup'),
          ),
        ],
      ),
    );
  }
}

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required String forom});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AuthenticationForm extends StatelessWidget {
  const AuthenticationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
        TextButton(
          onPressed: () {
            vm.logoutUser().then((value) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged out successfully')),
                );
              }
            });
          },
          child: Text('Logout'),
        ),
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
