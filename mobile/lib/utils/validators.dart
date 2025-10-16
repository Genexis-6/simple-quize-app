class KValidators {
  static String? validateInput({required String input}) {
    var data = input.trim();
    if (data == "") {
      return "Input can't be empty";
    }
    return null;
  }
}
