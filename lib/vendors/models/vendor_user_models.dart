class VendorUserModel {
  VendorUserModel({
    required this.approved, 
    required this.businessName, 
    required this.cityValue, 
    required this.countryValue, 
    required this.email, 
    required this.phoneNumber, 
    required this.stateValue, 
    required this.storeImage, 
    required this.taxNumber, 
    required this.taxRegistered
  });
  
  final bool? approved;
  final String? businessName;
  final String? cityValue;
  final String? countryValue;
  final String? email;
  final String? phoneNumber;
  final String? stateValue;
  final String? storeImage;
  final String? taxNumber;
  final String? taxRegistered;

  VendorUserModel.fromJson(Map<String, Object> json): 
  this(
    approved: json['approved']! as bool,
    businessName: json['businessName']! as String,
    cityValue: json['cityValue']! as String,
    countryValue: json['countryValue']! as String,
    email: json['email']! as String,
    phoneNumber: json['phoneNumber']! as String,
    stateValue: json['stateValue']! as String,
    storeImage: json['storeImage']! as String,
    taxNumber: json['taxNumber']! as String,
    taxRegistered: json['taxRegistered']! as String,
  );
}