// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  static String BASE_URL_IMAGE = dotenv.env['API_URL'] ?? '';

  static const String NEXT_PUBLIC_KEY_PASS = "";

  static const String USERNAME = "username";
  static const String PASSWORD = "password";
  static const String ACCESS_TOKEN = "accessToken";
  static const String REFRESH_TOKEN = "refreshToken";
  static const String NAME = 'name';
  static const String AVATAR = 'avatar';
  static const String ISSUING_AUTHORITY = 'issuing_authority';

  static const String FCMTOKEN = "fcm_token";
}
