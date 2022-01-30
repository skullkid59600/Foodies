import 'package:foodies/data/models/food_byarea.dart';

/// meals : [{"strArea":"American"},{"strArea":"British"},{"strArea":"Canadian"},{"strArea":"Chinese"},{"strArea":"Croatian"},{"strArea":"Dutch"},{"strArea":"Egyptian"},{"strArea":"French"},{"strArea":"Greek"},{"strArea":"Indian"},{"strArea":"Irish"},{"strArea":"Italian"},{"strArea":"Jamaican"},{"strArea":"Japanese"},{"strArea":"Kenyan"},{"strArea":"Malaysian"},{"strArea":"Mexican"},{"strArea":"Moroccan"},{"strArea":"Polish"},{"strArea":"Portuguese"},{"strArea":"Russian"},{"strArea":"Spanish"},{"strArea":"Thai"},{"strArea":"Tunisian"},{"strArea":"Turkish"},{"strArea":"Unknown"},{"strArea":"Vietnamese"}]

class All_foodarea_reponse {
  List<FoodArea>? _foodbyarea;

  List<FoodArea>? get foodarea => _foodbyarea;

  Food_Area({List<FoodArea>? foodarea}) {
    _foodbyarea = foodarea;
  }

  All_foodarea_reponse.fromJson(dynamic json) {
    if (json['foodarea'] != null) {
      _foodbyarea = [];
      json['foodarea'].forEach((v) {
        _foodbyarea?.add(FoodArea.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_foodbyarea != null) {
      map['foodarea'] = _foodbyarea?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
