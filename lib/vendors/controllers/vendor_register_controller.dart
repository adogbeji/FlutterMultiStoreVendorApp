import 'package:flutter/foundation.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;  // Stores firebase_storage package
  final FirebaseAuth _auth = FirebaseAuth.instance;  // Stores firebase_auth package

  // Stores profile picture in Firebase Storage
  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref = _storage.ref().child('storeImage').child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;
  }

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