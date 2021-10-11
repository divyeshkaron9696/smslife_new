class CityModel {
  String? state_id;
  String? city_id;
  String? city_name;

  CityModel({
    this.state_id,
    this.city_id,
    this.city_name,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    state_id = json["state_id"];
    city_id = json["city_id"];
    city_name = json["city_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["state_id"] = this.state_id;
    data["city_id"] = this.city_id;
    data["city_name"] = this.city_name;
    return data;
  }
}
