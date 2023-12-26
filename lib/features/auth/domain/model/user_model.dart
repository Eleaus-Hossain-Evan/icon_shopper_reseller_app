// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String address;
  final int special_discount;
  final String category_name;
  final int category_discount_percentage;
  final int total_discount;
  final String avatar;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.address,
    required this.special_discount,
    required this.category_name,
    required this.category_discount_percentage,
    required this.total_discount,
    required this.avatar,
  });

  factory UserModel.init() => const UserModel(
        id: 0,
        name: '',
        email: '',
        phone: '',
        gender: '',
        address: '',
        avatar: '',
        category_discount_percentage: 0,
        category_name: '',
        special_discount: 0,
        total_discount: 0,
      );

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? address,
    int? special_discount,
    String? category_name,
    int? category_discount_percentage,
    int? total_discount,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      special_discount: special_discount ?? this.special_discount,
      category_name: category_name ?? this.category_name,
      category_discount_percentage:
          category_discount_percentage ?? this.category_discount_percentage,
      total_discount: total_discount ?? this.total_discount,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'address': address,
      'special_discount': special_discount,
      'category_name': category_name,
      'category_discount_percentage': category_discount_percentage,
      'total_discount': total_discount,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      address: map['address'] ?? '',
      special_discount: map['special_discount']?.toInt() ?? 0,
      category_name: map['category_name'] ?? '',
      category_discount_percentage:
          map['category_discount_percentage']?.toInt() ?? 0,
      total_discount: map['total_discount']?.toInt() ?? 0,
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, gender: $gender, address: $address, special_discount: $special_discount, category_name: $category_name, category_discount_percentage: $category_discount_percentage, total_discount: $total_discount, avatar: $avatar)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phone,
      gender,
      address,
      special_discount,
      category_name,
      category_discount_percentage,
      total_discount,
      avatar,
    ];
  }
}
