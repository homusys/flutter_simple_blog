import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/users_controller.dart';
import 'package:flutter_simple_blog/utils/styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'views/profile_page.dart';
import 'views/home_page.dart';
import 'views/create_post_page.dart';
import 'views/login_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wgwdehciypbjpesrmlui.supabase.co',
    publishableKey: 'sb_publishable_fh9vaOsuX8sRyBihL0J9kA_DeRhlYWj',
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UsersController(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    /**TODO(homusyus): Add a theme for the app */
    return MaterialApp(
      title: 'Simple Blog App',
      home: AppNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => AppNavigatorState();
}

class AppNavigatorState extends State<AppNavigator> {
  int currentPageIndex = 0;

  void updatePageIndex(int index) {
    User? user = Supabase.instance.client.auth.currentUser;
    setState(() {
      currentPageIndex = index;

      if (user == null) {
        pages[2] = LoginPage();
      } else {
        pages[2] = ProfilePage();
      }
    });
  }

  final pages = <Widget>[HomePage(), CreatePostPage(), ProfilePage()];
  final appBarPageLabels = <String>[
    "Simple Blog App",
    "Create new post",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersController>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(appBarPageLabels[currentPageIndex]),
          backgroundColor: AppColors.primary.color,
          centerTitle: true,
        ),
        body: pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: updatePageIndex,
          destinations: <NavigationDestination>[
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.add), label: 'New Post'),
            NavigationDestination(
              icon: Icon(Icons.account_circle),
              label: value.getCurrentUserEmail(),
            ),
          ],
        ),
      ),
    );
  }
}
