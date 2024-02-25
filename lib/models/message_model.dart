
class MessageModel {
 final String? receiverId;
 final String? senderId;
 final String? dataTime;
 final String ?text;
 final String ?image;

  MessageModel({
    required this.receiverId,
    required this.senderId,
    required this.dataTime,
    required this.text,
    required this.image,
  });

 Map<String, dynamic> toMap() {
    return {
      'receiverId': this.receiverId,
      'senderId': this.senderId,
      'dataTime': this.dataTime,
      'text': this.text,
      'image': this.image,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      receiverId: map['receiverId'] as String,
      senderId: map['senderId'] as String,
      dataTime: map['dataTime'] as String,
      text: map['text'] as String,
      image: map['image'] as String,
    );
  }
}