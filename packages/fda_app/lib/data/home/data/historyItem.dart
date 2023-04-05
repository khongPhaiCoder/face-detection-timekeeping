import 'package:equatable/equatable.dart';

class HistoryItem extends Equatable {
  final String? status;
  final String? time;

  const HistoryItem({
    this.time,
    this.status,
  });
  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      time: json["time"],
      status: json["status"],
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [time, status];
}
