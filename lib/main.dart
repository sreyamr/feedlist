import 'package:flutter/material.dart';
import 'package:round2/provider/add_feed.dart';
import 'package:round2/provider/categorylist_provider.dart';
import 'package:round2/provider/home_provider.dart';
import 'package:round2/provider/login_provider.dart';
import 'package:round2/screens/add_feed_screen.dart';
import 'package:round2/screens/home_screen.dart';
import 'package:round2/screens/login_screen.dart';

import 'config/approutes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FeedListProvider()),
        ChangeNotifierProvider(create: (_) => AddFeed()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: AppRoutes.login,
        routes: getAppRoute(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}

Map<String,WidgetBuilder> getAppRoute(){
  return{
    AppRoutes.login:(context)=> LoginScreen(),
    AppRoutes.home:(context)=> const HomeScreen(),
    AppRoutes.addFeed:(context)=> const AddFeedScreen(),
  };
}
