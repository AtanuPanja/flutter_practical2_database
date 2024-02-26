bool validateName(String name) {
  // name field should not be empty
  return name.isNotEmpty;
}

bool validateGender(String gender) {
  // gender must not be empty, and must have one of these values
  return (gender.toLowerCase() == 'male' ||
      gender.toLowerCase() == 'female' ||
      gender.toLowerCase() == 'other');
}

bool validatePhone(String phone) {
  // phone must not be empty, and must have exactly 10 digits
  if (phone.length == 10) {
    int integerPhone = int.tryParse(phone) ?? -1;

    return (integerPhone != -1);
  }
  return false;
}