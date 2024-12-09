import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

const int HTML_GENERATION_STATUS_FAILURE = 0;

Future<Map<String, dynamic>> downloadPdf(BuildContext context, File generatedFile, String name) async {
  Directory? tempDir;
  String message = '';
  int status;

  try {
    // Get the temporary directory
    tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    final tempFileName = "${name}.pdf";
    final tempFilePath = '$tempPath/$tempFileName';
    final tempFile = File(tempFilePath);
    await tempFile.writeAsBytes(await generatedFile.readAsBytes());

    // Share the PDF file
    await Share.shareXFiles([XFile(tempFile.path)]);

    // Delete the temporary file after sharing
    await tempFile.delete();

    // Navigate back to the previous screen
    Navigator.pop(context);

    return {'status': 1, 'message': ''};  // No error, return empty message
  } catch (e) {
    status = HTML_GENERATION_STATUS_FAILURE;
    message = e.toString();
  }

  return {'status': status, 'message': message};
}
