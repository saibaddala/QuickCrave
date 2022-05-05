import 'package:foodart/backend/api_client.dart';
import 'package:foodart/backend/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.sharedPreferences,
    required this.apiClient,
  });

  Future<Response> registerUser(Map<String, dynamic> jsonSignUpData) async {
    return await apiClient.postData(AppConstants.signUpUrl, jsonSignUpData);
  }

  Future<Response> loginUser(Map<String, dynamic> jsonSignInData) async {
    return await apiClient.postData(AppConstants.signInUrl, jsonSignInData);
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.userToken, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.userToken) ?? "None";
  }

  bool checkIfThereExistsUserTokenInDatabase() {
    return sharedPreferences.containsKey(AppConstants.userToken);
  }

  Future<void> saveLoggedInUserNumberAndPassword(
      String number, String password) async {
    await sharedPreferences.setString(AppConstants.userPhoneNumber, number);
    await sharedPreferences.setString(AppConstants.userPassword, password);
  }

  Future<bool> clearAllUserDataStoredLocally() async {
    sharedPreferences.remove(AppConstants.userToken);
    sharedPreferences.remove(AppConstants.userPassword);
    sharedPreferences.remove(AppConstants.userPhoneNumber);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
