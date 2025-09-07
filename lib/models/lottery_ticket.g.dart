// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottery_ticket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LotteryTicketAdapter extends TypeAdapter<LotteryTicket> {
  @override
  final int typeId = 0;

  @override
  LotteryTicket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LotteryTicket(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      userNumbers: (fields[2] as List).cast<int>(),
      winningNumbers: (fields[3] as List).cast<int>(),
      matches: fields[4] as int,
      isWinner: fields[5] as bool,
      typeRate: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LotteryTicket obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.userNumbers)
      ..writeByte(3)
      ..write(obj.winningNumbers)
      ..writeByte(4)
      ..write(obj.matches)
      ..writeByte(5)
      ..write(obj.isWinner)
      ..writeByte(6)
      ..write(obj.typeRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LotteryTicketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
