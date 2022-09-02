import 'Action.dart';

class ActionList {
  List<Action> actionList = List<Action>.empty(growable: true);

  ActionList(this.actionList);

  ActionList.empty();
}