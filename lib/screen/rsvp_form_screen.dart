import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_micare/controller/register_controller.dart';
import 'package:flutter_micare/model/register_form_model.dart';
import 'package:flutter_micare/screen/function.dart';
import 'package:flutter_micare/screen/widget/custom_button.dart';
import 'package:flutter_micare/screen/widget/custom_text_field.dart';
import 'package:flutter_micare/shared/custom_color_code.dart';
import 'package:flutter_micare/shared/custom_text_style.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class RsvpForm extends StatelessWidget {
  const RsvpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.35,
            color: CustomColorCode.primaryColor,
          ),
          Container(
            margin: const EdgeInsets.only(top: kToolbarHeight),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'RSVP Form',
                  style: CustomTextStyle.titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: screenHeight * 0.065,
                  width: 2,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const VerticalDivider(
                    width: 2,
                    thickness: 2,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Kindly respond by February 06, 2021',
                  style: CustomTextStyle.bodyTextStyleLarge
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'We look forward to celebrate with you!',
                  style: CustomTextStyle.bodyTextStyleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _BuildForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildForm extends StatefulWidget {
  @override
  State<_BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<_BuildForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contacterController = TextEditingController();

  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please enter all the fields',
                    style: CustomTextStyle.bodyTextStyleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: CustomColorCode.secondaryColor),
                  ),
                  CustomTextField(
                    label: 'First Name',
                    hintText: 'Enter First Name',
                    controller: _firstNameController,
                    validator: (value) => validateName(value),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Last Name',
                    hintText: 'Enter Last Name',
                    controller: _lastNameController,
                    validator: (value) => validateName(value),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Contact Number',
                    hintText: 'Enter Contact Number',
                    controller: _contacterController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    validator: (value) => validateContactNumber(value),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Email',
                    hintText: 'Enter Email',
                    controller: _emailController,
                    validator: (value) => validateEmail(value),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Obx(() {
            Future.delayed(Duration.zero, () {
              switch (_registerController.registerStatus.value) {
                case RegisterStatus.success:
                  _showRegisterSuccessDialog(context: context);

                  break;
                case RegisterStatus.failure:
                  _showResgisterFailureMsg(context);
                  break;
                default:
              }
            });
            return Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: _registerController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : CustomElevatedButton(
                      text: 'Submit',
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          final RegisterFormModel registerFormModel =
                              RegisterFormModel(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  contactNumber: _contacterController.text,
                                  email: _emailController.text);

                          _registerController.register(registerFormModel);
                        }
                      }),
            );
          }),
        ],
      ),
    );
  }

  // Function to show success dialog
  void _showRegisterSuccessDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            titlePadding: const EdgeInsets.only(top: 18),
            title: Center(
              child: Text(
                "THANK YOU",
                style: CustomTextStyle.bodyTextStyleLarge.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: CustomColorCode.secondaryColor),
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Thank you for the submission. \nRSVP form was submitted successfully.",
                  textAlign: TextAlign.center,
                  style: CustomTextStyle.bodyTextStyleMedium,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                      text: 'Ok',
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ));
      },
    );
  }

  void _showResgisterFailureMsg(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Register unsuccesful. Please try again later.'),
      duration: Duration(seconds: 3), // Duration the SnackBar is visible
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _contacterController.dispose();
  }
}
