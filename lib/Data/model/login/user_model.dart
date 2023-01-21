class UserModel {
  String? firstName;
  String? lastName;
  String? username;
  String? countryCode;
  String? phone;
  DateTime? dateBirth;
  int? idGender;
  String? pathImg;
  String? token;
  DateTime? expiration;

  UserModel(
      {this.firstName,
        this.lastName,
        this.username,
        this.countryCode,
        this.phone,
        this.dateBirth,
        this.idGender,
        this.pathImg,
        this.token,
        this.expiration
      });

  factory UserModel.fromJson(json) {
    return UserModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'].toString(),
      countryCode: json['country_code'] as String,
      phone: json['phone'] as String,
      dateBirth: DateTime.parse(json['date_birth'].toString().replaceAll('T', ' ').replaceAll('Z', '')),
      idGender: json['id_gender'] as int,
      pathImg: json['path_img'].toString(),
      token: json['token'] as String,
      expiration: DateTime.parse(json['expiration'].toString().replaceAll('T', ' ').replaceAll('Z', '')),
    );
  }
}
