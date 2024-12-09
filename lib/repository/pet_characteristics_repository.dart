
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';


import '../models/pet_characteristics_data.dart';
import '../res/app_urls.dart';

class PetCharacteristicsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<PetCharacteristicsData> getPetCharacteristicsDataApi(String additionUrl) async {
    try {
      // print("additional url =${additionUrl}");
      // print("hitting pet characteristics api with: ${AppUrl.petCharacteristicsEndPoint}?$additionUrl");
      final response = await _apiServices.getGetApiResponse("${AppUrl.petCharacteristicsEndPoint}?$additionUrl");
      // print("pet_characteristics_repository $response");

      return PetCharacteristicsData.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
