import 'package:flutter/material.dart';

import 'package:country_state_city_picker_2/country_state_city_picker.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({super.key});

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  late String countryValue;

  late String stateValue;

  late String cityValue;

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
                          child: IconButton(
                            onPressed: () {},
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
                    keyboardType: TextInputType.name,  // Default??
                    decoration: const InputDecoration(
                      labelText: 'Business Name',
                    ),
                  ),

                  const SizedBox(height: 10,),

                  // EMAIL INPUT FIELD
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),

                  const SizedBox(height: 10,),

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
                                onStateChanged:(value) {
                                  setState(() {
                                    stateValue = value;
                                  });
                                },
                                 onCityChanged:(value) {
                                  setState(() {
                                    cityValue = value;
                                  });
                                },
                                
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