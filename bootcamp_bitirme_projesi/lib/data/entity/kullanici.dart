import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String email;
  String userName;


  Users(
      {
        required this.email,
        required this.userName,
        });

  Map<String, dynamic> toJson() => {
    'email': email,
    'userName': userName,
  };
  static Users fromJson(Map<String, dynamic> json) => Users(
      email: json['email'],
      userName: json['userName'],
      );

  factory Users.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Users(
        email: data?["email"],
        userName: data?["userName"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) "email": email,
      if (userName != null) "userName": userName,
    };
  }
}