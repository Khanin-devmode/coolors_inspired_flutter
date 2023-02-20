import 'package:coolors_inspired_flutter/pages/library_explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'pages/generate_palette_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Coolors Inspired',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      // home: GeneratePalettePage(),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const GeneratePalettePage(),
          ),
          GoRoute(
            path: '/library_explore',
            builder: (context, state) => const LibraryExplorePage(),
          ),
          // GoRoute(
          //   path: '/sign_in',
          //   builder: (context, state) => SignInScreen(
          //     providers: [],
          //   ),
          // ),
        ],
      ),
    );
  }
}
