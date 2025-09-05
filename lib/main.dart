import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loto_app/pages/detail_page.dart';
import 'package:loto_app/pages/main_page.dart';
import 'package:loto_app/pages/splash_screen.dart';
import 'package:loto_app/services/hive_repository.dart';

void main() async {
  //? Обеспечиваем инициализацию WidgetsBinding
  WidgetsFlutterBinding.ensureInitialized();

  //? Инициализируем Hive
  await HiveRepository.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle().copyWith(
      statusBarBrightness: Brightness.light,
      statusBarColor: const Color.fromARGB(255, 2, 110, 71),
      systemNavigationBarColor: Colors.white,
    ),
  );
  runApp(
    const ProviderScope(
      child: StartedPage(),
    ),
  );
}

class StartedPage extends StatelessWidget {
  const StartedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/mainPage": (context) => const MainPage(),
        "/cardDetail": (context) => const CardDetail(),
      },
    );
  }
}
