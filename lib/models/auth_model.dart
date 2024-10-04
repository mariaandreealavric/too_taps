class AuthModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  AuthModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });

  factory AuthModel.fromFirestore(Map<String, dynamic> data) {
    return AuthModel(
      uid: data['uid'],
      email: data['email'],
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }
}
