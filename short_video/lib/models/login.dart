class Login {
  String? email;
  String? password;

  Login({
    this.email,
    this.password,
  });

  mapToArray(){
    return {
      'email' : email,
      'password' : password,
    };
  }
  
}