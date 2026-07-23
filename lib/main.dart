import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/viewmodels/comments_viewmodel.dart';
import 'package:flutter_simple_blog/viewmodels/home_viewmodel.dart';
import 'package:flutter_simple_blog/viewmodels/users_viewmodel.dart';
import 'package:flutter_simple_blog/theme/main_app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'views/profile_page.dart';
import 'views/home_page.dart';
import 'views/posts/create_post_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wgwdehciypbjpesrmlui.supabase.co',
    publishableKey: 'sb_publishable_fh9vaOsuX8sRyBihL0J9kA_DeRhlYWj',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersViewmodel()),

        /// The home's viewmodel provider is moved to the top in order
        /// to avoid race conditions with the widget creation. When
        /// calling the notifyListeners() while creating the HomePage,
        /// the app tends to crash. I think this is because when we
        /// recreate the HomePage, A new instance of the viewmodel is
        /// being created too while the old viewmodel is still running
        /// its async function. then, when the old async method invokes
        /// the notifyListeners() while the new home is being rebuilt,
        /// an exception is being raised.
        ///
        ChangeNotifierProvider(create: (context) => HomeViewmodel()),
        ChangeNotifierProvider(create: (context) => CommentsViewmodel()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final MainAppTheme mainAppTheme = MainAppTheme();
  final String appTitle = 'Simple Blog App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainAppTheme.getMainTheme(),
      title: appTitle,
      home: AppNavigator(),
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

  Widget? updatePage(int index) {
    switch (index) {
      case 1:
        return pageMap["post"];
      case 2:
        return pageMap["profile"];
      default:
        return pageMap["home"];
    }
  }

  Widget? showUserAvatar(bool isLogged) {
    if (currentPageIndex == 2) {
      return null;
    }
    if (isLogged) {
      /// TODO: Replace with user's profile image if there is any
      return CircleAvatar();
    }
    return CircleAvatar(
      foregroundImage: AssetImage('assets/images/portrait.png'),
      backgroundImage: AssetImage('assets/images/portrait.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersViewmodel>(
      builder: (context, vm, child) => Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: showUserAvatar(vm.authService.isLoggedIn),
          ),
          title: Text(appBarPageLabels[currentPageIndex]),
          centerTitle: true,
        ),
        body: updatePage(vm.currentPageIndex),
        bottomNavigationBar: NavigationBar(
          selectedIndex: vm.currentPageIndex,
          onDestinationSelected: vm.updatePageIndex,
          destinations: <NavigationDestination>[
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.add), label: 'New Post'),
            NavigationDestination(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
