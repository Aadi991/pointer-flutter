import 'History.dart';

class HistoryList {
  List<History> historyList = List<History>.empty(growable: true);

  HistoryList(this.historyList);

  HistoryList.empty();
}