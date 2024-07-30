import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  const AuthResponse({this.phone, this.message, this.detail});

  final String? phone;
  final String? message;
  final String? detail;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      phone: json['phone'] as String?,
      message: json['message'] as String?,
      detail: json['detail'] as String?,
    );
  }

  @override
  List<Object?> get props => [phone, message, detail];
}
