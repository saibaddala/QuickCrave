import 'package:foodart/backend/api_client.dart';
import 'package:foodart/backend/models/sign_up_details_model.dart';
import 'package:foodart/backend/models/sign_up_response_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';

import '../repos/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<SignUpResponseModel> registerUser(
      SignUpDetailsModel signUpDetailsModel) async {
    _isLoading = true;
    update();
    Response responseFromServer =
        await authRepo.registerUser(signUpDetailsModel.toJson());
    late SignUpResponseModel signUpResponseModel;
    if (responseFromServer.statusCode == 200) {
      authRepo.saveUserToken(responseFromServer.body['token']);
      signUpResponseModel =
          SignUpResponseModel(true, responseFromServer.body['token']);
    } else {
      signUpResponseModel =
          SignUpResponseModel(false, responseFromServer.statusText!);
    }
    _isLoading = false;
    update();
    return signUpResponseModel;
  }
}
