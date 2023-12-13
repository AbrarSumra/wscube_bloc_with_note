import 'package:wscube_bloc_with_note/AppDataBase/app_db.dart';

class UserModel {
  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPass,
  });

  int userId;
  String userName;
  String userEmail;
  String userPass;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map[AppDataBase.COLUMN_USER_ID],
      userName: map[AppDataBase.COLUMN_USER_NAME],
      userEmail: map[AppDataBase.COLUMN_USER_EMAIL],
      userPass: map[AppDataBase.COLUMN_USER_PASS],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppDataBase.COLUMN_USER_NAME: userName,
      AppDataBase.COLUMN_USER_EMAIL: userEmail,
      AppDataBase.COLUMN_USER_PASS: userPass,
    };
  }
}
