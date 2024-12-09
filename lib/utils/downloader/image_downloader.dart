import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

// Define status codes
const int IMAGE_DOWNLOAD_STATUS_SUCCESS = 1;
const int IMAGE_DOWNLOAD_STATUS_FAILURE = 0;

Future<Map<String, dynamic>> downloadImages(List<Map<String, String>> imageUrlsAndNames) async {
  Dio dio = Dio();
  int downloadedCount = 0; // Track the number of successfully downloaded images
  const int timeoutSeconds = 7; // Timeout duration in seconds

  if (Platform.isAndroid) {
    // Request storage permissions
    if (await Permission.storage.request().isGranted) {
      Directory? downloadsDir = await getExternalStorageDirectory();
      if (downloadsDir == null) {
        print('Could not get the external storage directory');
        return {'status': IMAGE_DOWNLOAD_STATUS_FAILURE, 'count': 0, 'path': ''};
      }

      // Get the correct "Download" directory path
      final downloadsPath = '${downloadsDir.parent.parent.parent.parent.path}/Download';
      Directory downloadDirectory = Directory(downloadsPath);

      // Ensure the download directory exists
      if (!await downloadDirectory.exists()) {
        await downloadDirectory.create(recursive: true);
      }

      for (var imageInfo in imageUrlsAndNames) {
        String? imageUrl = imageInfo['url'];
        String imageName = imageInfo['name']!;

        // Check if the URL is valid
        if (imageUrl == null || imageUrl.isEmpty || !Uri.tryParse(imageUrl)!.hasAbsolutePath) {
          print('Invalid or empty URL, skipping: $imageUrl');
          continue;
        }

        String savePath = '$downloadsPath/$imageName.jpg'; // Change the file extension if necessary

        try {
          // Download the image with timeout
          await dio.download(imageUrl, savePath).timeout(Duration(seconds: timeoutSeconds));
          print('Downloaded: $savePath');
          downloadedCount++; // Increment the count of successfully downloaded images
        } catch (e) {
          print('Error downloading $imageUrl: $e');
          // If the error is due to timeout, end the process with an error message
          if (e is TimeoutException) {
            print('Download timed out');
            return {'status': IMAGE_DOWNLOAD_STATUS_FAILURE, 'count': downloadedCount, 'path': ''};
          }
        }
      }

      return {'status': IMAGE_DOWNLOAD_STATUS_SUCCESS, 'count': downloadedCount, 'path': downloadsPath};
    } else {
      print('Storage permission denied');
      return {'status': IMAGE_DOWNLOAD_STATUS_FAILURE, 'count': 0, 'path': ''};
    }
  }
  else if (Platform.isIOS) {
    // Request photo library permissions
    if (await Permission.photos.request().isGranted) {
      for (var imageInfo in imageUrlsAndNames) {
        String? imageUrl = imageInfo['url'];
        String imageName = imageInfo['name']!;

        print(imageName);
        // Check if the URL is valid
        if (imageUrl == null || imageUrl.isEmpty || !Uri.tryParse(imageUrl)!.hasAbsolutePath) {
          print('Invalid or empty URL, skipping: $imageUrl');
          continue;
        }

        try {
          // Download the image with timeout
          var response = await dio.get(
            imageUrl,
            options: Options(responseType: ResponseType.bytes),
          ).timeout(Duration(seconds: timeoutSeconds));

          // Save the image to the gallery
          final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 80,
            name: imageName,
          );

          if (result['isSuccess']) {
            print('Saved to gallery: $imageName');
            downloadedCount++; // Increment the count of successfully downloaded images
          } else {
            print('Error saving to gallery: $imageName');
          }
        } catch (e) {
          print('Error downloading $imageUrl: $e');
          // If the error is due to timeout, end the process with an error message
          if (e is TimeoutException) {
            print('Download timed out');
            return {'status': IMAGE_DOWNLOAD_STATUS_FAILURE, 'count': downloadedCount, 'path': ''};
          }
        }
      }

      return {'status': IMAGE_DOWNLOAD_STATUS_SUCCESS, 'count': downloadedCount, 'path': 'Photo Gallery'};
    } else {
      print('Photo library permission denied');
      return {'status': IMAGE_DOWNLOAD_STATUS_FAILURE, 'count': 0, 'path': ''};
    }
  } else {
    print('Unsupported platform');
    return {'status': IMAGE_DOWNLOAD_STATUS_FAILURE, 'count': 0, 'path': ''};
  }
}
