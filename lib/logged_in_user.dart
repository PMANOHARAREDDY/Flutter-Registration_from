class LoggedInUser {
  static final LoggedInUser _instance = LoggedInUser._internal();

  String? name;
  String? email;
  String? mobile;
  String? address;
  String? password;

  LoggedInUser._internal();

  factory LoggedInUser() {
    return _instance;
  }

  static LoggedInUser get instance => _instance;

  void setUser(String email, List<dynamic> userData) {
    this.email = email;
    name = userData[0];
    mobile = userData[1];
    address = userData[2];
    password = userData[3];
  }

  void updateUser(String newName, String newMobile, String newAddress, String newPassword) {
    name = newName;
    mobile = newMobile;
    address = newAddress;
    password = newPassword;
  }

  /// Optionally, to clear and reset the data of singleton on logout
  void clear() {
    name = null;
    email = null;
    mobile = null;
    address = null;
    password = null;
  }
}
