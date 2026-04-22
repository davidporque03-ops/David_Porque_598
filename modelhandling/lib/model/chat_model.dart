class Message {
  final int? id;
  final String username;
  final String message;
  final DateTime? createdAt;

  Message({
    this.id,
    required this.username,
    required this.message,
    this.createdAt,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    // task 4
    final rawId = map['id'];
    final int? id = rawId == null
        ? null
        : (rawId is int ? rawId : int.tryParse(rawId.toString()));

    final createdRaw = map['created_at'];
    final DateTime? createdAt = createdRaw == null
        ? null
        : (createdRaw is DateTime
              ? createdRaw
              : DateTime.parse(createdRaw.toString()));

    return Message(
      id: id,
      username: map['username']?.toString() ?? '',
      message: map['message']?.toString() ?? '',
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {'username': username, 'message': message};
  }
}
