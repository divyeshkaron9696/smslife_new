class MsgListModel {
  String? msgId;
  String? type;
  String? url;
  String? message;
  String? isActive;
  String? addedDateTime;

  MsgListModel(
      {
        this.msgId,
        this.type,
        this.url,
        this.message,
        this.isActive,
        this.addedDateTime,
      });

  MsgListModel.fromJson(Map<String, dynamic> json) {
    msgId = json['msgId'];
    type = json['type'];
    url = json['url'];
    message = json['message'];
    isActive = json['isActive'];
    addedDateTime = json['addedDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msgId'] = this.msgId;
    data['type'] = this.type;
    data['url'] = this.url;
    data['message'] = this.message;
    data['isActive'] = this.isActive;
    data['addedDateTime'] = this.addedDateTime;
    return data;
  }
}
