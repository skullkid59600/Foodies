/// strArea : "American"

class FoodAreas {
  String? _strArea;

  String? get strArea => _strArea;

  FoodAreas({String? strArea}) {
    _strArea = strArea;
  }

  FoodAreas.fromJson(dynamic json) {
    _strArea = json['strArea'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['strArea'] = _strArea;
    return map;
  }
}
