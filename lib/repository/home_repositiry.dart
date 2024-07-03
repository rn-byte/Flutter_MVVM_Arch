import 'package:flutter_mvvm/model/movies_model.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../res/app_url.dart';

class HomeRepositiry {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MoviesListModel> fetchMoviesList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.moviesUrlEndpoint);
      return response = MoviesListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
