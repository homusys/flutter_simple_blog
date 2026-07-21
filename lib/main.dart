import 'package:flutter/material.dart';
import 'package:flutter_simple_blog/controllers/posts_viewmodel.dart';
import 'package:flutter_simple_blog/controllers/users_viewmodel.dart';
import 'package:flutter_simple_blog/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final String appTitle = 'Simple Blog App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(colorPrimary),
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.bungee(),
          titleMedium: GoogleFonts.bungee(),
          titleSmall: GoogleFonts.bungee(),
          bodyLarge: GoogleFonts.quicksand(),
          bodyMedium: GoogleFonts.quicksand(),
          bodySmall: GoogleFonts.quicksand(),
          labelLarge: GoogleFonts.quicksand(fontWeight: FontWeight(700)),
          labelMedium: GoogleFonts.quicksand(fontWeight: FontWeight(700)),
          labelSmall: GoogleFonts.quicksand(),
        ),
      ),
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
