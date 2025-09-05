import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loto_app/models/lottery_ticket.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({
    super.key,
  });

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  int counter = 1;
  List<int> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final parametres = route?.settings.arguments as LotteryTicket;
    // ?? (route?.settings.name?.split('/').last);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 221, 194),
        title: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Тираж №${parametres.id}",
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
          padding: const EdgeInsets.all(30),
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
                                    parametres.date.toString().split(" ").first,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Icon(Icons.timelapse_sharp),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    parametres.date
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
                                const Expanded(
                                  child: Text(
                                    "Выберите 5 чисел",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      counter = 1;
                                      selectedValues.clear();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.refresh_rounded,
                                    color: Color.fromARGB(255, 142, 201, 179),
                                  ),
                                )
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
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (!selectedValues.contains(index + 1)) {
                                        if (selectedValues.length < 5) {
                                          selectedValues.add(index + 1);
                                        }
                                      } else {
                                        selectedValues.remove(index + 1);
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedValues.contains(index + 1)
                                          ? Colors.amber
                                          : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
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
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: 200,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 247, 120, 61),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (counter > 1) {
                                    counter--;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  '$counter',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (counter < 10) {
                                    counter++;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: 200,
                height: 50,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 2, 110, 71),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
