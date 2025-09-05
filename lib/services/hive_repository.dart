import 'package:hive_flutter/hive_flutter.dart';
import '../models/lottery_ticket.dart';

class HiveRepository {
  static const String _boxName = 'lotteryTicketsBox';
  static Box<LotteryTicket>? box;

  // Инициализация Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    // Регистрируем адаптер (сгенерированный код)
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LotteryTicketAdapter());
    }

    // Открываем Box
    box = await Hive.openBox<LotteryTicket>(_boxName);
  }

  // Добавить новый билет
  static Future<void> addTicket(LotteryTicket ticket) async {
    await box?.put(ticket.id, ticket);
  }

  // Получить все билеты (отсортированные по дате)
  static List<LotteryTicket> getAllTickets() {
    if (box == null) return [];

    final tickets = box!.values.toList();
    // Сортируем по дате (новые сверху)
    tickets.sort((a, b) => b.date.compareTo(a.date));
    return tickets;
  }

  // Получить билет по ID
  static LotteryTicket? getTicketById(String id) {
    return box?.get(id);
  }

  // Удалить билет
  static Future<void> deleteTicket(String id) async {
    await box?.delete(id);
  }

  // Очистить всю историю
  static Future<void> clearAll() async {
    await box?.clear();
  }

  // Количество билетов
  static int get ticketCount => box?.length ?? 0;

  // Получить только выигрышные билеты
  static List<LotteryTicket> getWinningTickets() {
    return getAllTickets().where((ticket) => ticket.isWinner).toList();
  }

  // Закрыть Box (вызывать при завершении приложения)
  static Future<void> close() async {
    await box?.close();
  }
}
