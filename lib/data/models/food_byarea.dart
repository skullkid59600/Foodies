/// meals : [{"strArea":"American"},{"strArea":"British"},{"strArea":"Canadian"},{"strArea":"Chinese"},{"strArea":"Croatian"},{"strArea":"Dutch"},{"strArea":"Egyptian"},{"strArea":"French"},{"strArea":"Greek"},{"strArea":"Indian"},{"strArea":"Irish"},{"strArea":"Italian"},{"strArea":"Jamaican"},{"strArea":"Japanese"},{"strArea":"Kenyan"},{"strArea":"Malaysian"},{"strArea":"Mexican"},{"strArea":"Moroccan"},{"strArea":"Polish"},{"strArea":"Portuguese"},{"strArea":"Russian"},{"strArea":"Spanish"},{"strArea":"Thai"},{"strArea":"Tunisian"},{"strArea":"Turkish"},{"strArea":"Unknown"},{"strArea":"Vietnamese"}]

class FoodArea {
  FoodArea({
    List<Meals>? meals,}){
    _meals = meals;
  }

  FoodArea.fromJson(dynamic json) {
    if (json['meals'] != null) {
      _meals = [];
      json['meals'].forEach((v) {
        _meals?.add(Meals.fromJson(v));
      });
    }
  }
  List<Meals>? _meals;

  List<Meals>? get meals => _meals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meals != null) {
      map['meals'] = _meals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// strArea : "American"

class Meals {
  Meals({
    String? strArea,}){
    _strArea = strArea;
  }

  Meals.fromJson(dynamic json) {
    _strArea = json['strArea'];
  }
  String? _strArea;

  String? get strArea => _strArea;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strArea'] = _strArea;
    return map;
  }

}