import 'package:flutter/material.dart';
import 'package:loto_app/models/lottery_ticket.dart';

class LotoCard extends StatelessWidget {
  final LotteryTicket ticket;
  final Function updateFunc;

  const LotoCard(
    this.ticket,
    this.updateFunc, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 200,
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Тираж №${ticket.id}",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 139, 196, 175),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ticket.result,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 139, 196, 175),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (ticket.userNumbers.isEmpty)
                SizedBox(
                  width: 125,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 247, 120, 61),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/cardDetail",
                        arguments: [
                          ticket,
                          updateFunc,
                        ],
                      );
                    },
                    child: const Center(
                      child: Text(
                        "Играть",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              spacing: 10,
              runSpacing: 5,
              children: [
                dataChip(
                  context,
                  ticket.date,
                  true,
                ),
                dataChip(
                  context,
                  ticket.date,
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dataChip(BuildContext context, DateTime dt, bool isDate) {
    return Container(
      width: 125,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 195, 240, 244),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: isDate
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    dt.toString().split(" ").first,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.timelapse_sharp),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  dt.toString().split(" ")[1].split('.').first,
                ),
              ],
            ),
    );
  }
}
