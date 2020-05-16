import 'package:awesome_map_mobile/base/providers/filterModel.dart';

class EventFilterModel extends FilterModel {
  DateTime startDate;
  DateTime endDate;
  String place = "";
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

  void setPlace(String place) {
    this.place = place;
    updateCounter();

    notifyListeners();
  }

  @override
  int checkChangedCounter() {
    int res = 0;
    if (this.title.isNotEmpty) res++;
    if (this.startDate != null) res++;
    if (this.endDate != null) res++;
    if (this.place.isNotEmpty) res++;
    return res;
  }

  @override
  void resetAllFields() {
    setTitle("");
    setStartDate(null);
    setEndDate(null);
    setPlace("");
  }
}
