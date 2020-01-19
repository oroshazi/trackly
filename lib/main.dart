import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackly_app/provider/activity_provider.dart';
import 'package:trackly_app/provider/category_provider.dart';
import 'package:trackly_app/provider/timer_provider.dart';
import 'package:trackly_app/screens/timer_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TimerProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CategoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ActivityProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        home: TimerScreen(),
      ),
    );
  }
}
