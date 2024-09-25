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

  VendorUserModel.fromJson(Map<String, object> json): this
}