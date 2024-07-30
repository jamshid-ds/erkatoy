import 'package:equatable/equatable.dart';

class ChildInfoDto extends Equatable {
  const ChildInfoDto({
    required this.message,
    this.userId,
    this.gender,
    this.weight,
    this.birthdayDate,
  });

  final String message;
  final String? userId;
  final String? gender;
  final num? weight;
  final String? birthdayDate;

  factory ChildInfoDto.fromJson(Map<String, dynamic> json) {
    return ChildInfoDto(
      message: json['message'] as String,
      userId: json['user_id'] as String?,
      gender: json['gender'] as String?,
      weight: json['weight'] as num?,
      birthdayDate: json['birthday'] as String?,
    );
  }

  @override
  List<Object?> get props => [message, userId, gender, weight, birthdayDate];
}
