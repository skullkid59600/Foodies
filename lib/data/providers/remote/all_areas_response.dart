import 'package:foodies/data/models/food_areas.dart';

/// meals : [{"strArea":"American"},{"strArea":"British"},{"strArea":"Canadian"},{"strArea":"Chinese"},{"strArea":"Croatian"},{"strArea":"Dutch"},{"strArea":"Egyptian"},{"strArea":"French"},{"strArea":"Greek"},{"strArea":"Indian"},{"strArea":"Irish"},{"strArea":"Italian"},{"strArea":"Jamaican"},{"strArea":"Japanese"},{"strArea":"Kenyan"},{"strArea":"Malaysian"},{"strArea":"Mexican"},{"strArea":"Moroccan"},{"strArea":"Polish"},{"strArea":"Portuguese"},{"strArea":"Russian"},{"strArea":"Spanish"},{"strArea":"Thai"},{"strArea":"Tunisian"},{"strArea":"Turkish"},{"strArea":"Unknown"},{"strArea":"Vietnamese"}]

class All_areas_response{
  AllAreasResponse2({
      List<FoodAreas>? foodAreas,}){
    _foodAreas = meals;
}

  All_areas_response.fromJson(dynamic json) {
    if (json['meals'] != null) {
      _foodAreas = [];
      json['meals'].forEach((v) {
        _foodAreas?.add(FoodAreas.fromJson(v));
      });
    }
  }
  List<FoodAreas>? _foodAreas;

  List<FoodAreas>? get meals => _foodAreas;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_foodAreas != null) {
      map['meals'] = _foodAreas?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}