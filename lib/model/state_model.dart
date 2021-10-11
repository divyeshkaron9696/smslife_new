class StateModel {
  String? state_id;
  String? state_name;

  StateModel({
    this.state_id,
    this.state_name,
  });

  StateModel.fromJson(Map<String, dynamic> json) {
    state_id = json["state_id"];
    state_name = json["state_name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["state_id"] = this.state_id;
    data["state_name"] = this.state_name;
    return data;
  }
}
