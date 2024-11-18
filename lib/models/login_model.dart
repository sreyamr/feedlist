class UserModel {
  final String countryCode;
  final String phone;

  UserModel({required this.countryCode, required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      countryCode: json['country_code'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_code': countryCode,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return '+$countryCode $phone';
  }
}
