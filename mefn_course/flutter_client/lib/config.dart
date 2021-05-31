import 'package:flutter/foundation.dart' as fondation;

class APIROUTES {
  static String get login {
    if (fondation.kIsWeb) {
      return 'http://localhost:3000/api/login';
    } else {
      return 'http://10.0.2.2:3000/api/login';
    }
  }

  static String get register {
    if (fondation.kIsWeb) {
      return 'http://localhost:3000/api/register';
    } else {
      return 'http://10.0.2.2:3000/api/register';
    }
  }

  static String get profile {
    if (fondation.kIsWeb) {
      return 'http://localhost:3000/api/profile';
    } else {
      return 'http://10.0.2.2:3000/api/profile';
    }
  }

  static String get logout {
    if (fondation.kIsWeb) {
      return 'http://localhost:3000/api/logout';
    } else {
      return 'http://10.0.2.2:3000/api/logout';
    }
  }

  static String get bookService {
    if (fondation.kIsWeb) {
      return 'http://localhost:3000/api/book';
    } else {
      return 'http://10.0.2.2:3000/api/book';
    }
  }

  static String get bookings {
    if (fondation.kIsWeb) {
      return 'http://localhost:3000/api/bookings';
    } else {
      return 'http://10.0.2.2:3000/api/bookings';
    }
  }
}
