import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {

  // Picks image from phone gallery or device camera
  pickStoreImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();  // Stores image_picker package

    XFile? _file = await _imagePicker.pickImage(source: source);  // Stores picked image

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected!');
    }
  }

  Future<String> registerVendor(
    String businessName, 
    String email, 
    String phoneNumber, 
    String countryValue, 
    String stateValue, 
    String cityValue, 
    String taxOptions, 
    String taxNumber,
    Uint8List? image
  ) async {
    String res = 'Some error occured';

    try {
      if (businessName.isNotEmpty &&
          email.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          countryValue.isEmpty &&
          stateValue.isNotEmpty &&
          cityValue.isNotEmpty &&
          taxOptions.isNotEmpty &&
          taxNumber.isNotEmpty &&
          image != null
      ) {
        // Save data to Firestore Database
      } else {
        res = 'Fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}