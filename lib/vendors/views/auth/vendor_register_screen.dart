import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:country_state_city_picker_2/country_state_city_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:multi_store_vendor/vendors/controllers/vendor_register_controller.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final VendorController _vendorController =
      VendorController(); // Stores VendorController class

  late String countryValue;

  late String stateValue;

  late String cityValue;

  Uint8List? _image; // Stores picked image

  String? _taxStatus;

  // Picks image from phone gallery
  selectGalleryImage() async {
    Uint8List im = await _vendorController
        .pickStoreImage(ImageSource.gallery); // Stores picked image

    setState(() {
      _image = im;
    });
  }

  // Captures image with phone camera
  selectCameraImage() async {
    Uint8List im = await _vendorController
        .pickStoreImage(ImageSource.camera); // Stores captured image

    setState(() {
      _image = im;
    });
  }

  List<String> _taxOptions = ['YES', 'NO'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pink,
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.yellow.shade900,
                        Colors.yellow,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _image != null
                              ? Image.memory(_image!)
                              : IconButton(
                                  onPressed: () {
                                    selectGalleryImage();
                                  },
                                  icon: const Icon(Icons.camera_alt),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // BUSINESS NAME INPUT FIELD
                  TextFormField(
                    keyboardType: TextInputType.name, // Default??
                    decoration: const InputDecoration(
                      labelText: 'Business Name',
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // EMAIL INPUT FIELD
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // PHONE INPUT FIELD
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tax Registered?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    
                        Flexible(
                          child: Container(
                            width: 100,
                            child: DropdownButtonFormField(
                              hint: const Text('Select'),
                                items: _taxOptions
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _taxStatus = value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (_taxStatus == 'YES')
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tax Number',
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
