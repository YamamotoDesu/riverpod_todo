import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/features/onboarding/pages/onboarding_page.dart';
import 'package:riverpod_todo/features/todo/pages/home_page.dart';
import 'package:riverpod_todo/firebase_options.dart';

import 'common/models/user_model.dart';
import 'common/routes/routes.dart';
import 'common/utils/constants.dart';
import 'features/auth/controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
      brightness: Brightness.dark, primarySwatch: Colors.blue);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users = ref.watch(userProvider);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 875),
      minTextAdapt: true,
      builder: (context, child) {
        return DynamicColorBuilder(
          builder: (
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
              home: users.isEmpty
                  ? const OnboardingPage()
                  : const OnboardingPage(),
              initialRoute: '/',
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          },
        );
      },
    );
  }
}
