import 'package:hive/hive.dart';

part 'lottery_ticket.g.dart';

@HiveType(typeId: 0)
class LotteryTicket {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final List<int> userNumbers;

  @HiveField(3)
  final List<int> winningNumbers;

  @HiveField(4)
  final int matches;

  @HiveField(5)
  final bool isWinner;

  LotteryTicket({
    required this.id,
    required this.date,
    required this.userNumbers,
    required this.winningNumbers,
    required this.matches,
    required this.isWinner,
  });

  // Конструктор для создания нового билета
  LotteryTicket.create({
    required this.winningNumbers,
  })  : id = DateTime.now().millisecondsSinceEpoch.toString(),
        date = DateTime.now(),
        isWinner = false,
        userNumbers = [],
        matches = _calculateMatches(
          [],
          winningNumbers,
        );

  static int _calculateMatches(List<int> user, List<int> winning) {
    return user.where((number) => winning.contains(number)).length;
  }

  String get result {
    if (userNumbers.isEmpty) return "Примите участие";
    if (matches >= 3) return 'Выигрыш ($matches из ${winningNumbers.length})';

    return 'Не выиграл ($matches из ${winningNumbers.length})';
  }
}
