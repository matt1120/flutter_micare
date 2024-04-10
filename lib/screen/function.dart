String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Name cannot be empty';
  } else if (value.length > 30) {
    return 'Please ensure that name is not longer than 30 characters';
  } else if (value.trim().contains(RegExp(r'[0-9]'))) {
    return 'Name cannot contain digits';
  }
  return null;
}

String? validateContactNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Contact Number cannot be empty';
  } else if (value.length != 10 && value.length != 11) {
    return 'Enter a valid contact number';
  }

  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email cannot be empty';
  }
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\\.,;:\s@\"]+\.)+[^<>()[\]\\.,;:\s@\"]{2,})$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}
