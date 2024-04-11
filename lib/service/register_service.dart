import 'package:flutter_micare/core/network_const.dart';
import 'package:flutter_micare/model/register_form_model.dart';
import 'package:get/get.dart';

class RegisterProvider extends GetConnect {
  Future<Response<String>> registerForm(RegisterFormModel registerFormModel) =>
      get('$myBaseUrl/interviewapi/AssessmentTestRSVP', query: {
        'ApiKey': '123456',
        'FirstName': registerFormModel.firstName,
        'LastName': registerFormModel.lastName,
        'ContactNo': registerFormModel.contactNumber,
        'Email': registerFormModel.email
      });
}
