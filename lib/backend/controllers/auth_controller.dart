import 'package:foodart/backend/models/sign_up_details_model.dart';
import 'package:foodart/backend/models/server_auth_response_model.dart';
import 'package:get/get.dart';
import '../repos/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ServerAuthResponseModel> registerUser(
      SignUpDetailsModel signUpDetailsModel) async {
    _isLoading = true;
    update();
    Response responseFromServer =
        await authRepo.registerUser(signUpDetailsModel.toJson());
    late ServerAuthResponseModel signUpResponseModel;
    if (responseFromServer.statusCode == 200) {
      authRepo.saveUserToken(responseFromServer.body['token']);
      signUpResponseModel =
          ServerAuthResponseModel(true, responseFromServer.body['token']);
    } else {
      signUpResponseModel =
          ServerAuthResponseModel(false, responseFromServer.statusText!);
    }

    _isLoading = false;
    update();
    return signUpResponseModel;
  }

  Future<ServerAuthResponseModel> loginUser(
      String mobileNumber, String password) async {
    _isLoading = true;
    update();
    Response responseFromServer = await authRepo.loginUser({
      'phone': mobileNumber,
      'password': password,
    });
    late ServerAuthResponseModel signInResponseModel;
    if (responseFromServer.statusCode == 200) {
      authRepo.saveUserToken(responseFromServer.body['token']);
      signInResponseModel =
          ServerAuthResponseModel(true, responseFromServer.body['token']);
    } else {
      signInResponseModel =
          ServerAuthResponseModel(false, responseFromServer.statusText!);
    }
    _isLoading = false;
    update();
    return signInResponseModel;
  }

  void saveUserNumberAndPasswordLocally(String number, String password) {
    authRepo.saveLoggedInUserNumberAndPassword(number, password);
  }

  bool isuserLoggedIn() {
    return authRepo.checkIfThereExistsUserTokenInDatabase();
  }

  void clearAllUserDataWhileLoggingOut() {
    authRepo.clearAllUserDataStoredLocally();
  }
}
