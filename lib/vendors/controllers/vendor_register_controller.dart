import 'package:flutter/foundation.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;  // Stores firebase_storage package
  final FirebaseAuth _auth = FirebaseAuth.instance;  // Stores firebase_auth package
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;  // Stores cloud_firestore package

  // Stores profile picture in Firebase Storage
  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref = _storage.ref()
                            .child('storeImage')
                            .child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);  // Stores result of uploaded image

    TaskSnapshot snapshot = await uploadTask;

    String downloadURL = await snapshot.ref.getDownloadURL();  // Stores image download URL

    return downloadURL;
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

  // Saves vendor data
  Future<String> registerVendor(
    String businessName, 
    String email, 
    String phoneNumber, 
    String countryValue, 
    String stateValue, 
    String cityValue, 
    String taxRegistered, 
    String taxNumber,
    Uint8List? image
  ) async {
    String res = 'Some error occured';

    try {
        String storeImage = await _uploadVendorImageToStorage(image);

        // Save data to Firestore Database
        await _firestore
            .collection('vendors')
            .doc(_auth.currentUser!.uid)
            .set({
              'businessName': businessName,
              'email': email,
              'phoneNumber': phoneNumber,
              'countryValue': countryValue,
              'stateValue': stateValue,
              'cityValue': cityValue,
              'taxRegistered': taxRegistered,
              'taxNumber': taxNumber,
              'storeImage': storeImage,
              'approved': false,
            });
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}