enum ChatSender { user, ai }

class ChatMessageModel {
  final String text;
  final ChatSender sender;
  final DateTime timestamp;

  ChatMessageModel({
    required this.text,
    required this.sender,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
