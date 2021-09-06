import 'package:email_validator/email_validator.dart';
import 'utils/khmer_phone_validator.dart';

class ValidatorService {
  String? validateEmail(String value) {
    if (EmailValidator.validate(value)) {
      return null;
    }

    return "Invalid Email";
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return null;
    }

    return "Password must be at least 8 charrector";
  }

  String? validatePhone(String value) {
    if (KhmerPhoneValidator.validPhone(value).status) {
      return null;
    }

    return "Invalid Phone number";
  }
}
