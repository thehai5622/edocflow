import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  // baseUrlImage
  static String BASE_URL_IMAGE = dotenv.env['API_URL'] ?? '';

  static const String NEXT_PUBLIC_KEY_PASS = "";

  static const String USERNAME = "username";
  static const String PASSWORD = "password";
  static const String ACCESS_TOKEN = "accessToken";
  static const String UUID_USER = "userName";
  static const String UUID_USER_ACC = "uuid";
  static const String FULL_NAME = 'fullName';
  static const String AVATAR_USER = "avatarUser";

  static const String FCMTOKEN = "fcm_token";
}
