import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sonipat_samaj/api/Environment.dart';
import 'package:sonipat_samaj/models/BannerListResponse.dart';
import 'package:sonipat_samaj/models/ChildListResponse.dart';
import 'package:sonipat_samaj/models/EventListResponse.dart';
import 'package:sonipat_samaj/models/NotificationListResponse.dart';
import 'package:sonipat_samaj/models/ProfessionListResponse.dart';
import 'package:sonipat_samaj/models/UserListResponse.dart';
import 'package:sonipat_samaj/models/Response.dart' as R;

import 'APIConstant.dart';

class APIService {
  Dio? dio;

  static header() => {"Content-Type": "application/json"};

  Future<APIService> init() async {
    dio = Dio(BaseOptions(baseUrl: Environment.url, headers: header()));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          // print(
          //     "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
          //         "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          // print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
          return handler.next(response);
        },
        onError: (err, handler) {
          print("Error[${err.response?.statusCode}]");
          return handler.next(err);
        },
      ),
    );
  }

  Future<R.Response> insertUserFCM(Map<String, dynamic> data) async {
    String url = APIConstant.insertUserFCM;
    var result = await Dio().post(url, data: data);

    R.Response response = R.Response.fromJson(json.decode(result.data));
    return response;
  }


  Future<UserListResponse> getUsers(Map<String, dynamic> queryParameters) async{
    try {
      String url = APIConstant.manageUser;
      var result = await dio!.get(url, queryParameters: queryParameters);
      UserListResponse userListResponse = UserListResponse.fromJson(
          json.decode(result.data));
      return userListResponse;
    } on SocketException catch (e) {
      print(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      print(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      print(e);
      throw Exception(e);
    } catch (e) {
      print(e);
      throw Exception("Something wen't wrong");
    }
  }

  Future<UserListResponse> getUsers1(Map<String, dynamic> queryParameters) async{
    try {
      String url = APIConstant.manageUser;
      var result = await dio!.get(url, queryParameters: queryParameters);
      print("result.data");
      print(result.data);
      UserListResponse userListResponse = UserListResponse.fromJson(
          json.decode(result.data));
      return userListResponse;
    } on SocketException catch (e) {
      print(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      print(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      print(e);
      throw Exception(e);
    } catch (e) {
      print(e);
      throw Exception("Something wen't wrong");
    }
  }

  Future<UserResponse> getUserDetails(Map<String, dynamic> queryParameters) async{

    String url = APIConstant.manageUser;
    print(url);
    print(queryParameters);
    var result = await dio!.get(url, queryParameters: queryParameters);
    print(result.data);
    UserResponse userResponse = UserResponse.fromJson(json.decode(result.data));
    return userResponse;
  }

  Future<ChildListResponse> getChildren(Map<String, dynamic> queryParameters) async{
    String url = APIConstant.manageChild;
    print(url);
    var result = await dio!.get(url, queryParameters: queryParameters);
    print(result.data);
    ChildListResponse childListResponse = ChildListResponse.fromJson(json.decode(result.data));
    return childListResponse;
  }

  Future<ProfessionListResponse> getProfessions() async{
    String url = APIConstant.getProfessions;
    print(url);
    var result = await dio!.get(url);
    print(result.data);
    ProfessionListResponse professionListResponse = ProfessionListResponse.fromJson(json.decode(result.data));
    return professionListResponse;
  }

  Future<EventListResponse> getEvents(Map<String, dynamic> queryParameters) async{
    try {
      String url = APIConstant.getEvents;
      print(url);
      var result = await dio!.get(url, queryParameters: queryParameters);
      print("result.data");
      print(result.data);
      EventListResponse eventListResponse = EventListResponse.fromJson(json.decode(result.data));
      return eventListResponse;
    } on SocketException catch (e) {
      print(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      print(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      print(e);
      throw Exception(e);
    } catch (e) {
      print(e);
      throw Exception("Something wen't wrong");
    }

  }

  Future<NotificationListResponse> getNotifications(Map<String, dynamic> queryParameters) async{
    try {
      String url = APIConstant.getNotifications;
      print(url);
      var result = await dio!.get(url, queryParameters: queryParameters);
      print("result.data");
      print(result.data);
      NotificationListResponse notificationListResponse = NotificationListResponse.fromJson(json.decode(result.data));
      return notificationListResponse;
    } on SocketException catch (e) {
      print(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      print(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      print(e);
      throw Exception(e);
    } catch (e) {
      print(e);
      throw Exception("Something wen't wrong");
    }

  }

  Future<BannerListResponse> getBanners(Map<String, dynamic> queryParameters) async{
    String url = APIConstant.manageBanner;
    print(url);
    var result = await Dio().get(url, queryParameters: queryParameters);
    print(result.data);
    BannerListResponse bannerListResponse = BannerListResponse.fromJson(json.decode(result.data));
    return bannerListResponse;
  }

  // Future<UserResponse> getUserDetails(Map<String, dynamic> queryParameters) async{
  //   String url = APIConstant.manageCustomer;
  //   Map<String, dynamic> headers = await getHeader();
  //   var result = await Dio().get(url, queryParameters: queryParameters, options: Options(headers: headers));
  //   UserResponse userResponse = UserResponse.fromJson(json.decode(result.data));
  //   return userResponse;
  // }

}
