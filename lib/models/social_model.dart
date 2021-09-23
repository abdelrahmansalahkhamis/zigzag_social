class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String cover;
  late String bio;
  late bool isVerifiedEmail;

  SocialUserModel(
      {required this.email,
      required this.name,
      required this.phone,
      required this.uId,
      required this.image,
      required this.cover,
      required this.bio,
      required this.isVerifiedEmail});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isVerifiedEmail = json['isVerifiedEmail'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isVerifiedEmail,
    };
  }
}
