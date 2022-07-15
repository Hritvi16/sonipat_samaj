import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sonipat_samaj/models/BannerListResponse.dart';
import 'package:sonipat_samaj/models/UserListResponse.dart';

import 'APIConstant.dart';

class APIService {
  // getHeader() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Map<String, dynamic> headers = {APIConstant.authorization : APIConstant.token+(sharedPreferences.getString("token")??"")+"."+base64Encode(utf8.encode(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())))};
  //   return headers;
  // }

  // getToken() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String token = sharedPreferences.getString("token")??"";
  //   return token;
  // }

  // Future<R.Response> insertUserFCM(Map<String, dynamic> data) async {
  //   String url = APIConstant.insertUserFCM;
  //   var result = await Dio().post(url, data: data);
  //
  //   R.Response response = R.Response.fromJson(json.decode(result.data));
  //   return response;
  // }


  Future<UserListResponse> getUsers(Map<String, dynamic> queryParameters) async{
    String url = APIConstant.manageUser;
    print(url);
    var result = await Dio().get(url, queryParameters: queryParameters);
    print(result.data);
    UserListResponse userListResponse = UserListResponse.fromJson(json.decode(result.data));
    return userListResponse;
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
