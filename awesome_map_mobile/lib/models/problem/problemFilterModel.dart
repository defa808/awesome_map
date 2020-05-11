import 'package:awesome_map_mobile/models/base/filterModel.dart';

class ProblemFilterModel extends FilterModel {
  DateTime startDate;
  DateTime endDate;
  String title = "";

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

  void setEndDate(DateTime date) {
    this.endDate = date;
    updateCounter();
    notifyListeners();
  }

  @override
  checkChangedCounter() {
    int res = 0;
    if (this.title.isNotEmpty) res++;
    if (this.startDate != null) res++;
    if (this.endDate != null) res++;
    return res;
  }

  @override
  resetAllFields() {
    setTitle("");
    setStartDate(null);
    setEndDate(null);
  }
}
