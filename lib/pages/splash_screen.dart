import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle().copyWith(
        statusBarBrightness: Brightness.light,
        statusBarColor: const Color.fromARGB(255, 2, 110, 71),
        systemNavigationBarColor: Colors.white,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 2, 110, 71),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Сыграй и Победи!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 0,
                            ),
                            child: Text(
                              "Игра для всех, кто любит попытать счастья в угадывании чисел.",
                              style: TextStyle(
                                color: Color.fromARGB(255, 127, 195, 170),
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: LottieBuilder.asset(
                  "lib/assets/anim/Fortune wheel.json",
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //? Возможно поменять на кнопку
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/mainPage");
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .08,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 120, 61),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Center(
                          child: Text(
                            'Вперёд',
                            style: TextStyle(
                              color: Color.fromARGB(255, 253, 251, 240),
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
