
class ApiResponse {
  String? status;
  String? message;
  Map<String,dynamic>? data;

  ApiResponse({this.status, this.message, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'].runtimeType==[].runtimeType?null:json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
class ApiListResponse {
  String? status;
  String? message;
  List<dynamic>? data;

  ApiListResponse({this.status, this.message, this.data});

  ApiListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}