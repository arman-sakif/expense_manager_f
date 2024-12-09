abstract class BaseApiServices {

  Future<dynamic> getPostApiResponse(String url , dynamic data);

  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPutApiResponse(String url, dynamic data);

  Future<dynamic> getPostFormDataApiResponse(String url, dynamic data);

}