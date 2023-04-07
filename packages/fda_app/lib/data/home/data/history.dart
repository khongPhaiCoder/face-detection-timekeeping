import 'package:equatable/equatable.dart';
import 'package:fda_app/data/home/data/historyItem.dart';

class HistoryObject extends Equatable {
  final String? date;
  final String? time;
  final String? id;
  final String? absent;
  final List<HistoryItem> histories;

  const HistoryObject({
    this.time,
    this.absent,
    this.date,
    this.id,
    this.histories = const [],
  });
  factory HistoryObject.fromJson(Map<String, dynamic> json) {
    List<HistoryItem> historiesList = [];
    if (json["hitories"] != null) {
      List listHistories = json["hitories"] as List;

      listHistories.forEach((element) {
        HistoryItem data = HistoryItem.fromJson(element);
        historiesList.add(data);
      });
    }
    print(historiesList);
    int val = int.parse(json["time"]);
    int currentHour = val ~/ 60;
    int currentMinute = val % 60;
    String time =
        '${currentHour}:${currentMinute < 10 ? '0' + currentMinute.toString() : currentMinute}';
    return HistoryObject(
      time: time,
      absent: json["absent"],
      id: json["_id"],
      date: json["date"],
      histories: historiesList,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [time, id, date, absent, histories];
}
