import 'package:flutter_micare/core/network_const.dart';
import 'package:flutter_micare/model/register_form_model.dart';
import 'package:get/get.dart';

class RegisterProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = myBaseUrl;
    super.onInit();
  }

  Future<Response<String>> registerForm(RegisterFormModel registerFormModel) =>
      post('$myBaseUrl/AssessmentTestRSVP', {
        'ApiKey': '123456',
        'FirstName': registerFormModel.firstName,
        'LastName': registerFormModel.lastName,
        'ContactNo': registerFormModel.contactNumber,
        'Email': registerFormModel.email
      });
}
