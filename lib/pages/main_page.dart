import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loto_app/widgets/card.dart';
import '../services/hive_repository.dart';
import '../models/lottery_ticket.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedItem = 0;
  List<LotteryTicket> lottery = [];

  @override
  void initState() {
    super.initState();
    getTickets();
  }

  void getTickets() async {
    setState(() {
      lottery = HiveRepository.getAllTickets();
    });
  }

  void clearTickets() async {
    await HiveRepository.clearAll();
    setState(() {
      lottery = HiveRepository.getAllTickets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            const Expanded(
              child: Text(
                "Играй сейчас!",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 228, 206, 170),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 237, 221, 194),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.green[400],
              ),
              onPressed: () {
                generateNewTicket();
              },
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 237, 221, 194),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: Colors.green[400],
              ),
              onPressed: () {
                clearTickets();
              },
              child: const Icon(
                Icons.delete_forever,
                color: Color.fromARGB(255, 237, 221, 194),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedItem,
        onTap: (int value) {
          setState(() {
            selectedItem = value;
          });
        },
        backgroundColor: const Color.fromARGB(255, 237, 221, 194),
        items: const [
          BottomNavigationBarItem(
            label: "Игра",
            icon: Icon(Icons.menu_open_outlined),
          ),
          BottomNavigationBarItem(
            label: "Результаты",
            icon: Icon(
              Icons.list_outlined,
              color: Colors.black,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: "Профиль",
          //   icon: Icon(Icons.account_circle),
          // ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 237, 221, 194),
          ),
          child: Column(
            children: [
              Expanded(
                child: lottery.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "lib/assets/img/box.png",
                            width: 100,
                            height: 100,
                          ),
                          const Text(
                            "Розыгрышей нет :(",
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < lottery.length; i++) ...[
                              LotoCard(
                                lottery[i],
                              ),
                            ],
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void generateNewTicket() {
    //? Генерируем случайные числа
    // final userNumbers = generateRandomNumbers(6, 1, 49);
    final winningNumbers = generateRandomNumbers(5, 1, 20);

    // Создаем билет
    final newTicket = LotteryTicket.create(
      winningNumbers: winningNumbers,
    );

    //? Сохраняем в Hive
    HiveRepository.addTicket(newTicket);

    //? Обновляем UI
    setState(() {
      getTickets();
    });
  }

  List<int> generateRandomNumbers(int count, int min, int max) {
    final numbers = <int>[];
    final random = Random();

    while (numbers.length < count) {
      final number = min + random.nextInt(max - min + 1);
      if (!numbers.contains(number)) {
        numbers.add(number);
      }
    }

    numbers.sort();
    return numbers;
  }
}
