import 'package:foodart/backend/models/user_model.dart';
import 'package:foodart/backend/repos/user_repo.dart';
import 'package:get/get.dart';

import '../models/sign_up_response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ServerAuthResponseModel> getUserInfo() async {
    Response responseFromServer = await userRepo.getUserInfo();
    late ServerAuthResponseModel signUpResponseModel;
    if (responseFromServer.statusCode == 200) {
      _userModel = UserModel.fromJson(responseFromServer.body);
      _isLoading = true;
      signUpResponseModel =
          ServerAuthResponseModel(true, "Successfully fetched");
    } else {
      signUpResponseModel =
          ServerAuthResponseModel(false, responseFromServer.statusText!);
    }
    update();
    return signUpResponseModel;
  }
}
