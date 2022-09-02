import 'Learner.dart';

class LearnerList {
  List<Learner> learnerList  = List<Learner>.empty(growable: true);

  LearnerList(this.learnerList);

  LearnerList.empty();
}