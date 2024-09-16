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
  final VendorController _vendorController = VendorController(); // Stores VendorController class

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();  // Form key

  late String businessName;

  late String email;

  late String phoneNumber;

  late String taxNumber;

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

  _saveVendorDetail() {
    if (_formKey.currentState!.validate()) {
      // print('Valid!');
      _vendorController.registerVendor(
        businessName, 
        email, 
        phoneNumber, 
        countryValue, 
        stateValue, 
        cityValue, 
        _taxStatus!, 
        taxNumber, 
        _image
      );
    } else {
      print('Not Valid!');
    }
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // BUSINESS NAME INPUT FIELD
                    TextFormField(
                      onChanged: (value) {
                        businessName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Business Name Must Not Be Empty!';
                        } else {
                          return null;  // Does nothing
                        }
                      },
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
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address Must Not Be Empty!';
                        } else {
                          return null;  // Does nothing
                        }
                      },
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
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number Must Not Be Empty!';
                        } else {
                          return null;  // Does nothing
                        }
                      },
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
                          onChanged: (value) {
                            taxNumber = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Tax Number Must Not Be Empty!';
                            } else {
                              return null;  // Does nothing
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tax Number',
                          ),
                        ),
                      ),
                      
                      // SAVE BUTTON
                      InkWell(
                        onTap: () {
                          _saveVendorDetail();
                        },
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text('Save', style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
