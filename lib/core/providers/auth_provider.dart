/// Authentication provider managing login state and user roles
library;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_campus/core/constants/app_constants.dart';
import 'package:e_campus/core/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isLoggedIn = false;
  bool _isFirstLaunch = true;
  String? _errorMessage;

  // ──── Getters ────
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  bool get isFirstLaunch => _isFirstLaunch;
  String? get errorMessage => _errorMessage;
  UserRole? get userRole => _currentUser?.role;
  String get userName => _currentUser?.name ?? 'User';
  String get userEmail => _currentUser?.email ?? '';

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (_isLoggedIn) {
      final role = prefs.getString('userRole') ?? 'student';
      _loadDemoUser(role);
    }
    notifyListeners();
  }

  void _loadDemoUser(String role) {
    switch (role) {
      case 'faculty':
        _currentUser = UserModel.demoFaculty();
        break;
      case 'admin':
        _currentUser = UserModel.demoAdmin();
        break;
      default:
        _currentUser = UserModel.demoStudent();
    }
  }

  /// Complete onboarding
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    _isFirstLaunch = false;
    notifyListeners();
  }

  /// Login with email and password (demo mode)
  Future<bool> login(String email, String password, UserRole role) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Demo mode: accept any valid-looking credentials
      if (email.isEmpty || password.isEmpty) {
        _errorMessage = 'Please enter email and password';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      if (password.length < 6) {
        _errorMessage = 'Password must be at least 6 characters';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Set demo user based on role
      switch (role) {
        case UserRole.student:
          _currentUser = UserModel.demoStudent();
          break;
        case UserRole.faculty:
          _currentUser = UserModel.demoFaculty();
          break;
        case UserRole.admin:
          _currentUser = UserModel.demoAdmin();
          break;
      }

      _isLoggedIn = true;

      // Persist login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userRole', role.name);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Login failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Register new user (demo mode)
  Future<bool> register(String name, String email, String password, UserRole role) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        _errorMessage = 'Please fill all fields';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Create user with provided details
      _currentUser = UserModel(
        uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        email: email,
        role: role,
        createdAt: DateTime.now(),
        isProfileComplete: false,
      );

      _isLoggedIn = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userRole', role.name);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Registration failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Forgot password
  Future<bool> forgotPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    return true; // Always succeeds in demo mode
  }

  /// Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userRole');

    _currentUser = null;
    _isLoggedIn = false;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }

  /// Update user profile
  void updateProfile(UserModel updatedUser) {
    _currentUser = updatedUser;
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
