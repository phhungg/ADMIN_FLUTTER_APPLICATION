class MyValidator {
  static String? uploadProText({String? value, String? toBeReturnedString}) {
    if (value!.isEmpty) {
      return toBeReturnedString;
    }
    return null;
  }
}
