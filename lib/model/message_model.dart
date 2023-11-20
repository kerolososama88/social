class MessageModel {
  String? senderId;
  String? recceivedId;
  String? dataTime;
  String? text;

  MessageModel({
    this.senderId,
    this.recceivedId,
    this.dataTime,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    recceivedId = json['recceivedId'];
    dataTime = json['dataTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recceivedId': recceivedId,
      'dataTime': dataTime,
      'text': text,
    };
  }
}
