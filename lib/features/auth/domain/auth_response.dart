// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'model/user_model.dart';

class AuthResponse extends Equatable {
  final bool success;
  final String? type;
  final String message;
  final String? access_token;
  final String? token_type;
  final int? expires_in;
  final UserModel? user;
  const AuthResponse({
    required this.success,
    required this.type,
    required this.message,
    required this.access_token,
    required this.token_type,
    required this.expires_in,
    required this.user,
  });

  AuthResponse copyWith({
    bool? success,
    ValueGetter<String?>? type,
    String? message,
    ValueGetter<String?>? access_token,
    ValueGetter<String?>? token_type,
    ValueGetter<int?>? expires_in,
    ValueGetter<UserModel?>? user,
  }) {
    return AuthResponse(
      success: success ?? this.success,
      type: type?.call() ?? this.type,
      message: message ?? this.message,
      access_token: access_token?.call() ?? this.access_token,
      token_type: token_type?.call() ?? this.token_type,
      expires_in: expires_in?.call() ?? this.expires_in,
      user: user?.call() ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'type': type,
      'message': message,
      'access_token': access_token,
      'token_type': token_type,
      'expires_in': expires_in,
      'user': user?.toMap(),
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      success: map['success'] ?? false,
      type: map['type'],
      message: map['message'] ?? '',
      access_token: map['access_token'],
      token_type: map['token_type'],
      expires_in: map['expires_in']?.toInt(),
      user: map['user'] != null && map['data'] == null
          ? UserModel.fromMap(map['user'])
          : map['user'] == null && map['data'] != null
              ? UserModel.fromMap(map['data'])
              : UserModel.init(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthResponse(success: $success, type: $type, message: $message, access_token: $access_token, token_type: $token_type, expires_in: $expires_in, user: $user)';
  }

  @override
  List<Object?> get props {
    return [
      success,
      type,
      message,
      access_token,
      token_type,
      expires_in,
      user,
    ];
  }
}
