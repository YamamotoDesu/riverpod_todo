import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/features/todo/pages/home_page.dart';

import 'common/utils/constants.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.blue);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 875),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(builder: (
          lightColorScheme,
          darkColorScheme,
        ) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppConst.kBkDark,
              colorScheme: lightColorScheme ?? defaultDarkColorScheme,
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: AppConst.kBkDark,
              colorScheme: darkColorScheme ?? defaultDarkColorScheme,
              useMaterial3: true,
            ),
            home: const HomePage(),
          );
        });
      },
    );
  }
}
