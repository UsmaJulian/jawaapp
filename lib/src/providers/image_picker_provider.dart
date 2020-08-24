import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  // Returns a [File] object pointing to the image that was picked.
  Future<File> pickImage({@required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    return File(pickedFile.path);
  }
}
