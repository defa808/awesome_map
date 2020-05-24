import 'package:awesome_map_mobile/base/providers/filterModel.dart';
import 'package:awesome_map_mobile/models/problem/problemStatus.dart';

class ProblemFilterModel extends FilterModel {
  DateTime createDate;
  String title = "";
  int status = -1;

  void setTitle(String value) {
    this.title = value;
    updateCounter();
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    this.createDate = date;
    updateCounter();
    notifyListeners();
  }

  void setStatus(ProblemStatus value) {
    this.status =
        ProblemStatus.values.indexWhere((element) => element == value);
    updateCounter();
    notifyListeners();
  }

  @override
  checkChangedCounter() {
    int res = 0;
    if (this.title.isNotEmpty) res++;
    if (this.createDate != null) res++;
    if (this.status != -1) res++;
    return res;
  }

  @override
  resetAllFields() {
    setTitle("");
    setStartDate(null);
    setStatus(null);
  }
}
