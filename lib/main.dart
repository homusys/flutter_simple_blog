import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/posts_viewmodel.dart';
import 'package:flutter_simple_blog/controllers/users_viewmodel.dart';
import 'package:flutter_simple_blog/utils/styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'views/profile_page.dart';
import 'views/home_page.dart';
import 'views/create_post_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wgwdehciypbjpesrmlui.supabase.co',
    publishableKey: 'sb_publishable_fh9vaOsuX8sRyBihL0J9kA_DeRhlYWj',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersViewmodel()),
        ChangeNotifierProvider(create: (context) => PostsViewmodel()),
      ],
      child: const MainApp(),
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
  final pageMap = {
    "home": HomePage(),
    "post": CreatePostPage(),
    "profile": ProfilePage(),
  };

  /// Used to change the scaffold title.
  final appBarPageLabels = <String>[
    "Simple Blog App",
    "Create new post",
    "Profile",
  ];

  int currentPageIndex = 0;

  void updatePageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  Widget? updatePage(UsersViewmodel controller) {
    switch (currentPageIndex) {
      case 1:
        return pageMap["post"];
      case 2:
        if (controller.authService.currentUser != null) {
          return pageMap["profile"];
        }
        return pageMap["profile"];
      default:
        return pageMap["home"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersViewmodel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(appBarPageLabels[currentPageIndex]),
          backgroundColor: AppColors.primary.color,
          centerTitle: true,
        ),
        body: updatePage(value),
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
