import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/companyDetails_model.dart';
import '../res/app_urls.dart';

class CompanydetailsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<CompanyDetailsModel> getCompanyDetailsApi(String skId) async {
    try {

      if(kDebugMode){
        print("SKID from company repository =${skId}");
        print('HITTING THE COMAPNY DETAILS API, WITH:${AppUrl.companyDetailsEndPoint}?pk_company_id=$skId');
      }
      final response = await _apiServices.getGetApiResponse("${AppUrl.companyDetailsEndPoint}?pk_company_id=$skId");
      if(kDebugMode) {
        // Print the raw response to check its structure
        // print("Raw response: $response");
      }
      // Check if response is already a Map
      if (response is Map<String, dynamic>) {
        // Debug print to inspect the response
        if(kDebugMode) {
          // print("Response is a Map: $response");
        }
        return CompanyDetailsModel.fromJson(response);
      }

      // If response is not a Map, decode it
      final Map<String, dynamic> jsonResponse = json.decode(response);
      print("Decoded JSON response: $jsonResponse");

      if (jsonResponse['statusCode'] == 200) {
        return CompanyDetailsModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load company details');
      }
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  Future<dynamic> updateCompanyApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPutApiResponse(AppUrl.companyUpdateEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}

