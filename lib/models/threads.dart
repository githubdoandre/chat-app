class ThreadsModel {
  final String identity;
  final String name;
  final String image;
  final Message lastMessage;
  final List<Message> messages;

  ThreadsModel(
      {this.identity, this.name, this.image, this.lastMessage, this.messages});

  factory ThreadsModel.fromJson(Map<String, dynamic> json) {
    var lastMessage = Message.fromJson(json['last_message']);

    var jsonList = json['messages'] as List;
    List<Message> msgs;
    if (jsonList != null) {
      msgs = jsonList.map((e) => Message.fromJson(e)).toList();
    }
    return ThreadsModel(
      identity: json['identity'],
      name: json['name'],
      lastMessage: lastMessage,
      messages: msgs,
      image: json['image'],
    );
  }
}

class Message {
  final String id;
  final String content;
  final String createdDate;
  final String from;
  final String to;
  final String status;

  Message(
      {this.id,
      this.content,
      this.createdDate,
      this.from,
      this.to,
      this.status});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      createdDate: json['createdDate'],
      from: json['from'],
      to: json['to'],
      status: json['status'],
    );
  }
}
