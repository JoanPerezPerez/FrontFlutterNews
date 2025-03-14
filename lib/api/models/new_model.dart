// ignore_for_file: file_names

class New {
  String? id;
  String? name;
  String? url;
  String? description;
  DateTime? dateStart;
  DateTime? dateEnd;
  String? image;
  bool? enabled;

  New({this.id, this.name, this.url, this.dateStart, this.dateEnd, this.description, this.image, this.enabled});

  New.fromJson(Map<String, dynamic> json) {
    id = json['_id']?.toString();
    name = json['name']?.toString();
    url = json['url']?.toString();
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
    data['url'] = url;
    data['description'] = description;
    data['dateStart'] = dateStart?.toIso8601String();
    data['dateEnd'] = dateEnd?.toIso8601String();
    data['image'] = image;
    data['enabled'] = enabled;

    return data;
  }
}