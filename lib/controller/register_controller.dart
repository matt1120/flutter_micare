import 'package:flutter/material.dart';
import 'package:flutter_micare/model/register_form_model.dart';
import 'package:flutter_micare/service/register_service.dart';
import 'package:get/state_manager.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSuccess = false.obs;
  final RegisterProvider _registerProvider = RegisterProvider();

  Future<void> register(RegisterFormModel registerFormModel) async {
    isLoading.value = true;
    try {
      var response = await _registerProvider.registerForm(registerFormModel);

      debugPrint('response: ${response.body}');
    } catch (e) {
      debugPrint('[RegisterController] registerForm error;  $e');
    } finally {
      isLoading.value = false;
    }
  }
}
