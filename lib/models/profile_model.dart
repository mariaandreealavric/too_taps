class ProfileModel {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  final String jobTitle;
  final String postImage;
  int touches;
  int scrolls;
  List<String> trophies;
  List<Map<String, dynamic>> challenges;

  ProfileModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.jobTitle,
    required this.postImage,
    this.touches = 0,
    this.scrolls = 0,
    this.trophies = const [],
    this.challenges = const [],
  });

  factory ProfileModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ProfileModel(
      uid: id,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      jobTitle: data['jobTitle'] ?? '',
      postImage: data['postImage'] ?? '',
      touches: data['touches'] ?? 0,
      scrolls: data['scrolls'] ?? 0,
      trophies: List<String>.from(data['trophies'] ?? []),
      challenges: List<Map<String, dynamic>>.from(data['challenges'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'jobTitle':  jobTitle,
      'postImage': postImage,
      'touches': touches,
      'scrolls': scrolls,
      'trophies': trophies,
      'challenges': challenges,
    };
  }

  ProfileModel copyWith({
    String? displayName,
    String? email,
    String? photoUrl,
    String? jobTitle,
    String? postImage,
    int? touches,
    int? scrolls,
    List<String>? trophies,
    List<Map<String, dynamic>>? challenges,
  }) {
    return ProfileModel(
      uid: uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      jobTitle: jobTitle ?? this.jobTitle,
      postImage: postImage ?? this.postImage,
      touches: touches ?? this.touches,
      scrolls: scrolls ?? this.scrolls,
      trophies: trophies ?? this.trophies,
      challenges: challenges ?? this.challenges,
    );
  }
}