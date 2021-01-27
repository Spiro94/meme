import 'package:http/http.dart';
import 'package:meme/core/constants/base_urls.dart';

import 'package:meme/core/http/request_types.dart';

Future<Response> makeRequest(
  String endpoint,
  Client client,
  HttpRequestType type, {
  Map<String, dynamic> body,
}) async {
  String url = BaseUrls.baseUrl + endpoint;
  Response response;
  Map headers = {'Content-Type': 'applcation/json'};

  switch (type) {
    case HttpRequestType.Get:
      response = await client.get(url, headers: headers);
      break;
    case HttpRequestType.Post:
      response = await client.post(url, headers: headers, body: body);
      break;
    case HttpRequestType.Put:
      response = await client.put(url, headers: headers, body: body);
      break;
    case HttpRequestType.Delete:
      response = await client.delete(url, headers: headers);
      break;
    default:
  }

  return response;
}
