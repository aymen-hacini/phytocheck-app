import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL ?? "",
    );
  }

  // Method to update user profile image
  UserModel copyWith({String? profileImageUrl}) {
    return UserModel(
      uid: uid,
      email: email,
      displayName: displayName,
      photoUrl: profileImageUrl ?? photoUrl,
    );
  }
}
