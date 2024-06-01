class ChangePassword {
  String? password;
  String? newPassword;

  ChangePassword({
    required this.password,
    required this.newPassword,
  });

  mapToArray(){
    return {
      'old_password' : password,
      'new_password' : newPassword,
    };
  }
}