import 'package:foodies/data/models/food_areas.dart';

/// meals : [{"strArea":"American"},{"strArea":"British"},{"strArea":"Canadian"},{"strArea":"Chinese"},{"strArea":"Croatian"},{"strArea":"Dutch"},{"strArea":"Egyptian"},{"strArea":"French"},{"strArea":"Greek"},{"strArea":"Indian"},{"strArea":"Irish"},{"strArea":"Italian"},{"strArea":"Jamaican"},{"strArea":"Japanese"},{"strArea":"Kenyan"},{"strArea":"Malaysian"},{"strArea":"Mexican"},{"strArea":"Moroccan"},{"strArea":"Polish"},{"strArea":"Portuguese"},{"strArea":"Russian"},{"strArea":"Spanish"},{"strArea":"Thai"},{"strArea":"Tunisian"},{"strArea":"Turkish"},{"strArea":"Unknown"},{"strArea":"Vietnamese"}]

class All_foodarea_reponse {
  List<FoodAreas>? _foodAreas;

  List<FoodAreas>? get foodAreas => _foodAreas;

  Food_Area({List<FoodAreas>? foodarea}) {
    _foodAreas = foodarea;
  }

  All_foodarea_reponse.fromJson(dynamic json) {
    if (json['foodarea'] != null) {
      _foodAreas = [];
      json['foodarea'].forEach((v) {
        _foodAreas?.add(FoodAreas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_foodAreas != null) {
      map['foodarea'] = _foodAreas?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
