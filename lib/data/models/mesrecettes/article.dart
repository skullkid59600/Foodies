class Article {

  int? id;
  String? nom;
  String?  image;
  String?  ingredients;
  String?  desc;

  Article();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nom = map['nom'];
    this.image = map['image'];
    this.ingredients = map['ingredients'];
    this.desc = map['desc'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'nom': this.nom,
      'image': this.image,
      'ingredients': this.ingredients,
      'desc': this.desc
    };

    if (id != null) {
      map['id'] = this.id;
    }
    return map;
  }

}