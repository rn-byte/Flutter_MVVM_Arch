import 'dart:convert';
import 'dart:io';
import 'package:flutter_mvvm/data/app_exception.dart';
import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      return FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(
        const Duration(
          seconds: 10,
        ),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      return FetchDataException('No Internet Connection');
    }
    return responseJson;
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);

      return responseJson;
    case 400:
      return BadRequestException(response.body.toString());
    case 404:
      return UnauthorizedException(response.body.toString());

    default:
      throw FetchDataException(
          'Error occured while communicating with server with status code ${response.statusCode}');
  }
}
