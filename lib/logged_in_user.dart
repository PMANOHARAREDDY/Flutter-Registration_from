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

  // Fill all values from a List (typically from DB)
  void setUser(String email, List<dynamic> userData) {
    this.email = email;
    name = userData[0];
    mobile = userData[1];
    address = userData[2];
    password = userData[3];
  }

  // Update in-memory data only!
  void updateUser(String newName, String newMobile, String newAddress, String newPassword) {
    name = newName;
    mobile = newMobile;
    address = newAddress;
    password = newPassword;
    // NO database writing here!
    // Only update the DB from your UI or controller using DBHelper.
  }

  // Optionally, a helper to clear/reset the singleton (on logout)
  void clear() {
    name = null;
    email = null;
    mobile = null;
    address = null;
    password = null;
  }
}
