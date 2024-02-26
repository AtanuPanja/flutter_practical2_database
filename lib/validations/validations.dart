bool validateName(String name) {
  return name.isNotEmpty;
}

bool validateGender(String gender) {
  return (gender.toLowerCase() == 'male' ||
      gender.toLowerCase() == 'female' ||
      gender.toLowerCase() == 'other');
}

bool validatePhone(String phone) {
  if (phone.length == 10) {
    int integerPhone = int.tryParse(phone) ?? -1;

    return (integerPhone != -1);
  }
  return false;
}