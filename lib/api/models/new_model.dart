// ignore_for_file: file_names

class New {
  String? id;
  String? name;
  String? description;
  DateTime? dateStart;
  DateTime? dateEnd;
  String? image;
  bool? enabled;

  New({this.id, this.name, this.dateStart, this.dateEnd, this.description, this.image, this.enabled});

  New.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    name = json['name']?.toString();
    description = json['description']?.toString();
    dateStart =  json['dateStart'] != null ? DateTime.tryParse(json['dateStart']) : null;
    dateEnd =  json['dateEnd'] != null ? DateTime.tryParse(json['dateEnd']) : null;
    image = json['image']?.toString();
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['dateStart'] = dateStart;
    data['dateEnd'] = dateEnd;
    data['image'] = image;
    data['enabled'] = enabled;

    return data;
  }
}