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
      'sort': 'date_added:desc',
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

  Future<IssueDetails> getIssueDetails(String url) async {
    Map<String, dynamic> parameters = {
      'api_key': Env.apiKey,
      'format': 'json',
      'field_list': 'image,characterCredits,teamCredits,locationCredits',
    };
    var dio = Dio();
    IssueDetails result;
    try {
      Response response = await dio.get(
        url,
        queryParameters: parameters,
      );
      result = IssueDetails.fromJson(response.data['result']);
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
