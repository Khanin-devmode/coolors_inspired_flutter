import 'package:coolors_inspired_flutter/features/library_and_explore/presentation/library_explore_page.dart';
import 'package:coolors_inspired_flutter/features/library_and_explore/presentation/view_palette_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'features/generate_palette/presentation/generate_palette_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
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
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            // path: '/temp',
            builder: (context, state) => const GeneratePalettePage(),
          ),
          GoRoute(
            path: '/library_explore',
            builder: (context, state) => const LibraryExplorePage(),
          ),
          GoRoute(
            path: '/view_palette',
            // path: '/',
            builder: (context, state) => const ViewPalettePage(),
          ),
        ],
      ),
    );
  }
}
