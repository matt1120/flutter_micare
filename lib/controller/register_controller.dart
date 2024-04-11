import 'package:flutter/material.dart';
import 'package:flutter_micare/model/register_form_model.dart';
import 'package:flutter_micare/service/register_service.dart';
import 'package:get/state_manager.dart';

enum RegisterStatus { initial, success, failure, loading }

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<RegisterStatus> registerStatus = RegisterStatus.initial.obs;
  final RegisterProvider _registerProvider = RegisterProvider();

  Future<void> register(RegisterFormModel registerFormModel) async {
    isLoading.value = true;
    registerStatus.value = RegisterStatus.loading;

    try {
      var response = await _registerProvider.registerForm(registerFormModel);

      if (response.statusCode == 200) {
        registerStatus.value = RegisterStatus.success;
      } else {
        registerStatus.value = RegisterStatus.failure;
      }
    } catch (e) {
      debugPrint('[RegisterController] registerForm error;  $e');
    } finally {
      isLoading.value = false;
    }
  }
}
