import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiry;
  String _userId;
  Timer _authTime;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_token != null && _expiry.isAfter(DateTime.now()) && _expiry != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlAttach) async {
    final uri =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlAttach?key=AIzaSyAIT30jGbNcvz6klZLjxcbUsvLcLATk7wU';
    final url = Uri.parse(uri);
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final postResponse = jsonDecode(response.body);
      if (postResponse['error'] != null) {
        throw HttpException(postResponse['error']['message']);
      }
      _token = postResponse['idToken'];
      _expiry = DateTime.now()
          .add(Duration(seconds: int.parse(postResponse['expiresIn'])));
      _userId = postResponse['localId'];
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiry': _expiry.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final userData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    if (DateTime.parse(userData['expiry']).isBefore(DateTime.now())) {
      return false;
    }
    _token = userData['token'];
    _expiry = DateTime.parse(userData['expiry']);
    _userId = userData['userId'];
    notifyListeners();
    autoLogout();

    return true;
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    _expiry = null;
    if (_authTime != null) {
      _authTime.cancel();
      _authTime = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }

  void autoLogout() {
    if (_authTime != null) {
      _authTime.cancel();
    }
    var timeExpiry = _expiry.difference(DateTime.now()).inSeconds;
    _authTime = Timer(Duration(seconds: timeExpiry), logout);
  }
}
