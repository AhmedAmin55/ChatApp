class MessageModel {
  final String message;

  MessageModel(this.message);

  factory MessageModel.fromjason(jasonData) {
    return MessageModel(jasonData['message']);
  }
}
