import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart' as dio;
import 'package:get/get_core/src/get_main.dart';
import 'package:probcell_solutions/routes/app_routes.dart';
import 'dart:io'; // Import for HttpClient

class ApiClient extends getx.GetxService {
  late dio.Dio _dio;
  var options = dio.BaseOptions(
    headers: {'Accept': 'application/json', 'Content-Type': 'application/x-www-form-urlencoded'},
    baseUrl: 'http://probecellpress.com/api',
    connectTimeout: Duration(seconds: 15000),
    receiveTimeout: Duration(seconds: 3000),
  );

  final _register = '/register';
  final _checkUserRegister = '/user-exists';
  final _verifyOtp = '/verify-otp';
  final _addDetails = '/add-details';
  final _isUserAdmin = '/is-user-admin';
  final _login = '/login';
  final _resendOtp = '/resend-otp';
  final _changePassword = '/change-password';
  final _changeUserDetails = '/change-user-details';
  final _categories = '/categories';
  final _subcategories = '/subcategories';
  final _typesOfWork = '/types-of-work';
  final _areas = '/areas';
  final _courses = '/courses';
  final _searchHistory = '/search-history';
  final _messages = '/messages';
  final _sendMessage = '/send-message';
  final _userDetails = '/user-details';
  final _newSearchRequest = '/new-search-request';
  final _adminSendMessage = '/admin/send-message';
  final _adminGetAllMessage = '/admin/messages';
  final _adminGetUseerMessage = '/admin/get-user-message/';

  ApiClient() {
    _dio = dio.Dio(options);
    _dio = DioForNative(options);
  }

  Future<ApiClient> init() async {
    return this;
  }

  void addAuthTokenInHeader(String accessToken) {
    options.headers["Authorization"] = 'Bearer ${accessToken.toString()}';
    _dio = dio.Dio(options);
  }

  void removeAuthTokenInHeader() {
    if (options.headers.containsKey("Authorization")) {
      options.headers.remove("Authorization");
    }
    _dio = dio.Dio(options);
  }

  Future register({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _register,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future checkUserRegister({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _checkUserRegister,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future verifyOtp({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _verifyOtp,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future addDetails({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _addDetails,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future isUserAdmin({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _isUserAdmin,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e.response!.statusCode);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future login({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _login,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        onError(e.response?.data);
        // return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future resendOtp({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _resendOtp,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        onError(e.response?.data);
        // return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future changePassword({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _changePassword,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future changeUserDetails({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _changeUserDetails,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError('Something Went Wrong! ${e.response?.data}'); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}'); // Include exception info
    }
  }

  Future categories({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _categories,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! 2 ${e.toString()}'); // Include exception info
    }
  }

  Future subcategories({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _subcategories,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! 2 ${e.toString()}'); // Include exception info
    }
  }

  Future typesOfWork({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _typesOfWork,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! 2 ${e.toString()}'); // Include exception info
    }
  }

  Future areas({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _areas,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! 2 ${e.toString()}'); // Include exception info
    }
  }

  Future courses({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _courses,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! 2 ${e.toString()}'); // Include exception info
    }
  }

  Future searchHistory({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _searchHistory,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! 2 ${e.toString()}'); // Include exception info
    }
  }

  Future messages({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _messages,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data); // Improved error message
      }
    } catch (e) {
      onError('Something Went Wrong! 2 ${e.toString()}'); // Include exception info
    }
  }

  Future sendMessage({
    // Modified method name
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    required dio.FormData formData,
    String? message,
  }) async {
    try {
      var response = await _dio.post(_sendMessage,
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'multipart/form-data',
            },
          ));

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      onError(e.response?.data);
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}');
    }
  }

  Future sendMessageOnly({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _sendMessage,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      onError(e.response?.data);
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}');
    }
  }

  Future getUserDetails({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _userDetails,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      print(e);
      if (e.response != null && e.response!.statusCode == 401) {
        return Get.offAllNamed(Routes.login);
      } else {
        onError(e.response?.data);
      }
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}');
    }
  }

  Future newSearchRequest({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    // Map<String, dynamic> requestData = const {},
    required dio.FormData formData,
  }) async {
    try {
      var response = await _dio.post(_newSearchRequest,
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'multipart/form-data',
            },
          ));

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      onError(e.response?.data);
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}');
    }
  }

  Future adminSendMessage({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    required dio.FormData formData,
    String? message,
  }) async {
    try {
      var response = await _dio.post(_adminSendMessage,
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'multipart/form-data',
            },
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      onError(e.response?.data);
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}');
    }
  }

  Future sendAdminMessageOnly({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.post(
        _adminSendMessage,
        data: requestData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      onError(e.response?.data);
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}');
    }
  }

  Future adminGetAllMessage({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _adminGetAllMessage,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      onError(e.response?.data);
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}');
    }
  }

  Future adminGetUserMessage({
    required Function(dynamic resp) onSuccess,
    required Function(dynamic error) onError,
    required String userId,
    Map<String, dynamic> requestData = const {},
  }) async {
    try {
      var response = await _dio.get(
        _adminGetUseerMessage + userId,
        data: requestData,
      );

      if (response.statusCode == 200) {
        onSuccess(response.data);
      } else {
        onError(response.data);
      }
    } on DioException catch (e) {
      onError(e.response?.data);
    } catch (e) {
      onError('Something Went Wrong! ${e.toString()}');
    }
  }
}
