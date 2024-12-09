import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isConnectedStatus = true.obs; // Renamed observable
  final _connectionStatusStream = StreamController<bool>.broadcast();

  @override
  void onInit() {
    super.onInit();
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen((results) {
      _updateConnectionStatus(results);
    });
    // Check initial connectivity state
    checkInitialConnection();
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    for (var result in results) {
      if (result == ConnectivityResult.none) {
        // No internet, show dialog if not already shown
        if (Get.isDialogOpen != true) {
          Get.dialog(
            NoInternetScreen(), // Your custom no internet screen
            barrierDismissible: false,
          );
        }
        isConnectedStatus.value = false;
        _connectionStatusStream.add(false);
      } else {
        // Check for real internet connectivity
        bool hasInternet = await _hasRealInternetConnection();
        isConnectedStatus.value = hasInternet;
        _connectionStatusStream.add(hasInternet);

        if (hasInternet) {
          // Close the no internet dialog if it is open
          if (Get.isDialogOpen == true) {
            print("back-- connection");
            Get.back();
          }
        } else {
          // Re-show the dialog if there is no real internet
          if (Get.isDialogOpen != true) {
            Get.dialog(
              NoInternetScreen(), // Your custom no internet screen
              barrierDismissible: false,
            );
          }
        }
      }
    }
  }

  // Check initial connection status when app starts
  Future<void> checkInitialConnection() async {
    var result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  // Method to check if the device is connected to the internet
  Future<bool> isConnected() async {
    var result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    }
    return await _hasRealInternetConnection(); // Perform actual internet check
  }

  // Utility method to check for real internet connection
  Future<bool> _hasRealInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
  // Expose connection status stream
  Stream<bool> get connectionStatusStream => _connectionStatusStream.stream;
}

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.noInternetConnection,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Optionally add retry logic here
              },
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      ),
    );
  }
}


// class NetworkController extends GetxController {
//   final Connectivity _connectivity = Connectivity();
//   final RxBool _isNoInternetScreenVisible = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
//   void _updateConnectionStatus(List<ConnectivityResult> results) {
//         for (var result in results) {
//           if (result == ConnectivityResult.none) {
//             if (!_isNoInternetScreenVisible.value) {
//               _isNoInternetScreenVisible.value = true;
//               Get.off(() => NoInternetScreen(
//                 onRetry: _checkConnection,
//               ));
//             }
//           } else {
//             if (_isNoInternetScreenVisible.value) {
//               _isNoInternetScreenVisible.value = false;
//               Get.back(); // Close the NoInternetScreen
//             }
//           }
//
//         }
//   }
//
//   void _checkConnection() async {
//     try {
//       var connectivityResult = await _connectivity.checkConnectivity();
//       if (connectivityResult != ConnectivityResult.none) {
//         // Connection is restored
//         if (_isNoInternetScreenVisible.value) {
//           _isNoInternetScreenVisible.value = false;
//           Get.back(); // Close the NoInternetScreen
//         }
//         // Optionally show a snackbar or other indication that the connection is restored
//         Get.rawSnackbar(
//           messageText: const Text(
//             'Internet connection restored',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//           backgroundColor: Colors.green[400]!,
//           icon: const Icon(Icons.check, color: Colors.white, size: 35),
//           snackStyle: SnackStyle.GROUNDED,
//         );
//       }
//     } catch (e) {
//       // Handle errors here if needed
//       print("Error checking connectivity: $e");
//     }
//   }
// }

// class NetworkController extends GetxController {
//   final Connectivity _connectivity = Connectivity();
//   final RxBool _isNoInternetScreenVisible = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
//   void _updateConnectionStatus(List<ConnectivityResult> results) {
//     for (var result in results) {
//       if (result == ConnectivityResult.none) {
//         if (!_isNoInternetScreenVisible.value) {
//           _isNoInternetScreenVisible.value = true;
//           Get.off(() => NoInternetScreen(
//             onRetry: _checkConnection,
//           ));
//         }
//       } else {
//         if (_isNoInternetScreenVisible.value) {
//           _isNoInternetScreenVisible.value = false;
//           // Ensure the NoInternetScreen is popped, regardless of the navigation history
//           if (Get.currentRoute == '/no_internet_screen') {
//             // Use Get.offAll to replace the NoInternetScreen if it's the only screen
//             Get.offAllNamed('/home'); // Or replace '/home' with your initial route
//           } else {
//             Get.back(); // Close the NoInternetScreen if there is a previous screen
//           }
//         }
//       }
//     }
//
//   }
//
//   void _checkConnection() async {
//     try {
//       var connectivityResult = await _connectivity.checkConnectivity();
//       if (connectivityResult != ConnectivityResult.none) {
//         // Connection is restored
//         if (_isNoInternetScreenVisible.value) {
//           _isNoInternetScreenVisible.value = false;
//           // Ensure the NoInternetScreen is popped, regardless of navigation history
//           if (Get.currentRoute == '/no_internet_screen') {
//             Get.offAllNamed('/home'); // Or replace '/home' with your initial route
//           } else {
//             Get.back(); // Close the NoInternetScreen
//           }
//         }
//         // Optionally show a snackbar or other indication that the connection is restored
//         Get.rawSnackbar(
//           messageText: const Text(
//             'Internet connection restored',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//             ),
//           ),
//           backgroundColor: Colors.green[400]!,
//           icon: const Icon(Icons.check, color: Colors.white, size: 35),
//           snackStyle: SnackStyle.GROUNDED,
//         );
//       }
//     } catch (e) {
//       // Handle errors here if needed
//       print("Error checking connectivity: $e");
//     }
//   }
// }


// class NetworkController extends GetxController {
//   final Connectivity _connectivity = Connectivity();
//
//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
//   void _updateConnectionStatus(List<ConnectivityResult> results) {
//     for (var result in results) {
//       if (result == ConnectivityResult.none) {
//         Get.rawSnackbar(
//             messageText: const Text(
//                 'PLEASE CONNECT TO THE INTERNET',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14
//                 )
//             ),
//             // isDismissible: false,
//             duration: const Duration(days: 1),
//             backgroundColor: Colors.red[400]!,
//             icon : const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
//             margin: EdgeInsets.zero,
//             snackStyle: SnackStyle.GROUNDED
//         );
//       } else {
//         if (Get.isSnackbarOpen) {
//           Get.closeCurrentSnackbar();
//         }
//       }
//     }
//   }
//
// }


