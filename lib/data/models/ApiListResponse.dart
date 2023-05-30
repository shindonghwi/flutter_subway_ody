import 'package:flutter/cupertino.dart';

class ApiListResponse<T> {
  final int status;
  final String message;
  final T? list;
  final int count;

  ApiListResponse({
    required this.status,
    required this.message,
    required this.list,
    required this.count,
  });

  factory ApiListResponse.fromJson(
    Map<String, dynamic>? json,
    T Function(dynamic) fromJsonT,
  ) {
    try {
      debugPrint('ApiListResponse.fromJson: ${ApiListResponse(
        status: json!['status'] as int,
        message: json['message'] as String,
        list: fromJsonT(json['list']),
        count: json['count'] as int,
      )}');
      return ApiListResponse(
        status: json['status'] as int,
        message: json['message'] as String,
        list: fromJsonT(json['list']),
        count: json['count'] as int,
      );
    } catch (e) {
      debugPrint('ApiResponse.fromJson: ${ApiListResponse(
        status: json!['status'] as int,
        message: json['message'] as String,
        list: fromJsonT(json['list']),
        count: json['count'] as int,
      )}');
      return ApiListResponse(
        status: json['status'] as int,
        message: json['message'] as String,
        list: fromJsonT(json['list']),
        count: json['count'] as int,
      );
    }
  }
}
