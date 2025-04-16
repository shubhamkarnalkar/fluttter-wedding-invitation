import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wedding_project/utils/localization/app_localization.dart';
import 'package:wedding_project/utils/localization/lang_text_constants.dart';

class GlobalMessenger {
  static void showSnackBarMessage(
      {required BuildContext context, String? error, String? message}) {
    if (error != null) {
      message = error;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message ?? ''),
          backgroundColor: error == null ? null : Colors.red,
        ),
      );
  }

  static List<String> messageFormatter(Object obj, [bool isLoginPage = false]) {
    try {
      throw obj;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          return ['401', 'Login Failed'];
        case DioExceptionType.connectionTimeout:
          // TODO: lang
          return [
            e.response?.statusCode.toString() ?? '400',
            'Connection time out'
          ];

        case DioExceptionType.connectionError:
          // TODO: lang
          return [
            e.response?.statusCode.toString() ?? '401',
            'Connection Error'
          ];
        default:
          return [
            e.response?.statusCode.toString() ?? '400',
            e.message.toString()
          ];
      }
    } catch (e) {
      return ['0', LangTextConstants.msg_something_went_wrong.tr];
    }
  }
}
