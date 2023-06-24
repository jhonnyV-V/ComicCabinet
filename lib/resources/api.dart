import 'package:comic_cabinet/env/env.dart';
import 'package:comic_cabinet/models/issue.dart';
import 'package:comic_cabinet/models/issue_details.dart';
import 'package:comic_cabinet/utils/constants.dart';
import 'package:dio/dio.dart';

class Api {
  final baseApi = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<Issue>> getIssues({offset = 0}) async {
    Map<String, dynamic> parameters = {
      'api_key': Env.apiKey,
      'format': 'json',
      'field_list': 'name,issue_number,date_added,image,api_detail_url',
      'limit': 10,
      // 'sort': 'date_added:desc',
      'offset': offset,
    };
    List<Issue> results = [];
    try {
      Response response = await baseApi.get(
        '/issues',
        queryParameters: parameters,
        options: Options(responseType: ResponseType.json),
      );
      results = Issue.fromArray(response.data['results']);
    } on DioException catch (err) {
      if (err.response != null) {
        if (err.response!.statusCode == 401) {
          print('Invalid Api key');
        }
      } else {
        print(err.requestOptions);
        print(err.message);
      }
    }
    return results;
  }

  Future<String> getCreditImage(String url) async {
    Map<String, dynamic> parameters = {
      'api_key': Env.apiKey,
      'format': 'json',
      'field_list': 'image',
    };
    var dio = Dio();
    try {
      Response response = await dio.get(
        url,
        queryParameters: parameters,
      );
      return response.data['results']['image']['original_url'];
    } on DioException catch (err) {
      if (err.response != null) {
        if (err.response!.statusCode == 401) {
          print('Invalid Api key');
          throw Error();
        }
        throw Error();
      } else {
        print(err.requestOptions);
        print(err.message);
        throw Error();
      }
    }
  }

  Future<IssueDetails> getIssueDetails(String url) async {
    Map<String, dynamic> parameters = {
      'api_key': Env.apiKey,
      'format': 'json',
      'field_list':
          'image,character_credits,team_credits,location_credits,concept_credits',
    };
    var dio = Dio();
    IssueDetails result;
    try {
      Response response = await dio.get(
        url,
        queryParameters: parameters,
      );
      Map<String, dynamic> populatedData = {};
      Map<String, dynamic> results = response.data['results'];
      populatedData['image'] = results['image']['original_url'];
      List<String> list = [
        'character_credits',
        'team_credits',
        'location_credits',
        'concept_credits',
      ];

      for (var credits in list) {
        if (results[credits] != null) {
          populatedData[credits] = <Map<String, dynamic>>[];
          for (var element in results[credits]) {
            Map<String, dynamic> credit = {
              'name': element['name'],
            };
            credit['image'] = await getCreditImage(
              element['api_detail_url'],
            );
            populatedData[credits].add(credit);
          }
        }
      }
      result = IssueDetails.fromJson(populatedData);
      return result;
    } on DioException catch (err) {
      if (err.response != null) {
        if (err.response!.statusCode == 401) {
          print('Invalid Api key');
          throw Error();
        }
        throw Error();
      } else {
        print(err.requestOptions);
        print(err.message);
        throw Error();
      }
    }
  }
}
