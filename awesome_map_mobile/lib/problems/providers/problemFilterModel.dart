
import 'package:awesome_map_mobile/base/providers/filterModel.dart';
import 'package:awesome_map_mobile/models/problem/problemStatus.dart';

class ProblemFilterModel extends FilterModel {
  DateTime startDate;
  String title = "";
  ProblemStatus status;

  void setTitle(String value) {
    this.title = value;
    updateCounter();
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    this.startDate = date;
    updateCounter();
    notifyListeners();
  }

 void setStatus(ProblemStatus value) {
    this.status = value;
    updateCounter();
    notifyListeners();
  }

  @override
  checkChangedCounter() {
    int res = 0;
    if (this.title.isNotEmpty) res++;
    if (this.startDate != null) res++;
    if (this.status != null) res++;
    return res;
  }

  @override
  resetAllFields() {
    setTitle("");
    setStartDate(null);
    setStatus(null);
  }
}
