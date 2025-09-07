import 'package:flutter/material.dart';
import 'package:loto_app/models/lottery_ticket.dart';
import 'package:loto_app/services/hive_repository.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({
    super.key,
  });

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  int counter = 1;
  String typeRate = "";
  List<int> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final parametres = route?.settings.arguments as List<dynamic>;
    // ?? (route?.settings.name?.split('/').last);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 221, 194),
        title: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Тираж №${parametres[0].id}",
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 237, 221, 194),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 250,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 228, 206, 172),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(Icons.calendar_month),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    parametres[0]
                                        .date
                                        .toString()
                                        .split(" ")
                                        .first,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Icon(Icons.timelapse_sharp),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    parametres[0]
                                        .date
                                        .toString()
                                        .split(" ")[1]
                                        .split('.')
                                        .first,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 2, 110, 71),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    selectedValues.length == 5
                                        ? "Подтвердите выбор"
                                        : "Выберите 5 чисел",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      shadowColor: Colors.transparent,
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        2,
                                        110,
                                        71,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        typeRate = '';
                                        selectedValues.clear();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.refresh_rounded,
                                      color: Color.fromARGB(255, 142, 201, 179),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisExtent: 50,
                                childAspectRatio: .8,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemCount: selectedValues.length == 5 ? 5 : 20,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (!selectedValues.contains(
                                          selectedValues.length == 5
                                              ? selectedValues[index]
                                              : index + 1)) {
                                        if (selectedValues.length < 5) {
                                          selectedValues.add(
                                              selectedValues.length == 5
                                                  ? selectedValues[index]
                                                  : index + 1);
                                        }
                                      } else {
                                        selectedValues.remove(
                                            selectedValues.length == 5
                                                ? selectedValues[index]
                                                : index + 1);
                                      }
                                      selectedValues.sort();
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedValues.contains(
                                              selectedValues.length == 5
                                                  ? selectedValues[index]
                                                  : index + 1)
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        selectedValues.length == 5
                                            ? "${selectedValues[index]}"
                                            : '${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(10),
                      //   width: 200,
                      //   decoration: const BoxDecoration(
                      //     color: Color.fromARGB(255, 247, 120, 61),
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(15),
                      //     ),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       SizedBox(
                      //         width: 40,
                      //         height: 40,
                      //         child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             padding: const EdgeInsets.all(0),
                      //             shadowColor: Colors.transparent,
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           onPressed: () {
                      //             setState(() {
                      //               if (counter > 1) {
                      //                 counter--;
                      //               }
                      //             });
                      //           },
                      //           child: const Icon(
                      //             Icons.remove,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Center(
                      //           child: Text(
                      //             '$counter',
                      //             style: const TextStyle(
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 40,
                      //         height: 40,
                      //         child: ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             padding: const EdgeInsets.all(0),
                      //             shadowColor: Colors.transparent,
                      //             backgroundColor: Colors.transparent,
                      //           ),
                      //           onPressed: () {
                      //             setState(() {
                      //               if (counter < 10) {
                      //                 counter++;
                      //               }
                      //             });
                      //           },
                      //           child: const Icon(
                      //             Icons.add,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // if (selectedValues.length == 5)
                      SizedBox(
                        height: 200,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    typeRate = "bet";
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Тип ставки",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Одноразовая ставка",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    overflow: TextOverflow.fade,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 30,
                                            color: typeRate == "bet"
                                                ? const Color.fromARGB(
                                                    255, 247, 120, 61)
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    typeRate = "subscribe";
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Тип ставки",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Подписка",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 30,
                                            color: typeRate == "subscribe"
                                                ? const Color.fromARGB(
                                                    255, 247, 120, 61)
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ],
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
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shadowColor: Colors.transparent,
                    backgroundColor: const Color.fromARGB(255, 2, 110, 71),
                  ),
                  onPressed: () {
                    if (selectedValues.length < 5 || typeRate == "") {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text(
                            "Предупреждение",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 2, 110, 71),
                          content: const Text(
                            "Вы выбрали не все значения или тип ставки",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text(
                                    "Хорошо",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      try {
                        updateTicket();
                      } catch (_) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text(
                              "Ошибка",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 2, 110, 71),
                            content: const Text(
                              "Произошла ошибка",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text(
                                      "Закрыть",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      Navigator.pop(context);
                      parametres[1]();
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text(
                            "Уведомление",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 2, 110, 71),
                          content: const Text(
                            "Вы стали участником лоттереи!",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text(
                                    "Отлично",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Подтвердить',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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

  void updateTicket() {
    final route = ModalRoute.of(context);
    final parametres = route?.settings.arguments as List<dynamic>;

    //? Создаем билет
    final newTicket = LotteryTicket.update(
      id: parametres[0].id,
      winningNumbers: parametres[0].winningNumbers,
      date: parametres[0].date,
      isWinner: parametres[0].isWinner,
      userNumbers: selectedValues,
      matches: parametres[0].matches,
      typeRate: typeRate,
    );

    //? Сохраняем в Hive
    HiveRepository.updateTicket(newTicket);
  }
}
