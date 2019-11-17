class LoginResponse {
  String usertoken;

  LoginResponse(this.usertoken);

  LoginResponse.map(dynamic obj){
    this.usertoken = obj["user-token"];
  }
}