import 'package:flutter/foundation.dart';

class AppUrl {

  static var baseUrl = "https://j871vxq2lk.execute-api.ca-central-1.amazonaws.com/dev";


  static var signupEndPoint = baseUrl + '/sign_up';
  static var verificationEndPoint = baseUrl + '/email_verification';
  static var signInEndPoint = baseUrl + '/sign_in';
  static var expenseListEndPoint = baseUrl + '/get_user_expenses';
  static var expenseMonthlyEndPoint = baseUrl + '/calculate_expenses';
  static var childListEndPoint = baseUrl + '/pet_child_list';
  static var parentDetailsEndPoint = baseUrl + '/pet_parent_details';
  static var outsideFatherDetailsEndPoint = baseUrl + '/outside_father_details';
  static var userDetailsEndPoint = baseUrl + '/get_user_data';
  static var userUpdateEndPoint = baseUrl + '/user_update';
  static var parentUpdateEndPoint = baseUrl + '/pet_parent_update';
  static var expenseEntryEndPoint = baseUrl + '/add_expense';
  static var outsideFatherEntryEndPoint = baseUrl + '/outside_father_add';
  static var memberListEndPoint = baseUrl + '/company_member_list';
  static var growthEntryEndPoint = baseUrl + '/pet_child_add';
  static var growthDetailsEndPoint = baseUrl + '/pet_child_details';
  static var viewGrowthListEndPoint = baseUrl + '/pet_view_growth_list';
  static var viewGrowthSearchEndPoint = baseUrl + '/pet_view_growth_search';
  static var companyDetailsEndPoint = baseUrl + '/company_details';
  static var companyUpdateEndPoint = baseUrl + '/admin_company_update';
  static var childGrowthEndPoint = baseUrl + '/pet_child_day_update';
  static var childGrowthRecordedEndPoint = baseUrl + '/pet_child_status_update';
  static var petCharacteristicsEndPoint = baseUrl + '/pet_varient_data';
  static var changePasswordEndPoint = baseUrl + '/change_password';

  ///new
  static var resetPasswordRequestEndPoint =
      baseUrl + '/user_password_reset_request';
  static var resetPasswordConfirmEndPoint =
      baseUrl + '/user_confirm_password_reset';
  static var petChildUpdateEndPoint = baseUrl + '/pet_child_update';

  /// push notification
  static var createNotificationChannelEndPoint =
      baseUrl + '/create_app_endpoint';
  static var sendPushNotificationEndPoint = baseUrl + '/send_push_notification';
}
