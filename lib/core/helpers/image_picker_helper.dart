import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> getImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    XFile? image;
    if (imageSource == ImageSource.camera) {
      final cameraPer = await Permission.camera.request();
      if (cameraPer.isGranted) {
        try {
          image = await _picker.pickImage(
            source: ImageSource.camera,
            maxHeight: 480,
            maxWidth: 360,
            imageQuality: 80,
          );
        } catch (e) {
          return null;
        }
      }
    } else if (imageSource == ImageSource.gallery) {
      var photosPer = await Permission.manageExternalStorage.request();
      if (photosPer.isGranted) {
        try {
          image = await _picker.pickImage(
            source: ImageSource.gallery,
            maxHeight: 480,
            maxWidth: 360,
            imageQuality: 80,
          );
        } catch (e) {
          return null;
        }
      }
      return image;
    }
    return null;
  }
}
