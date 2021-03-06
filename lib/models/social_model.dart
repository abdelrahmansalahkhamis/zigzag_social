class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isVerifiedEmail;

  SocialUserModel(this.email, this.name, this.phone, this.uId, this.image,
      this.cover, this.bio, this.isVerifiedEmail);

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

class UserModel {
  String? name;
  String? phone;
  String? uId;

  UserModel(this.name, this.phone, this.uId);

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uId': uId,
    };
  }
}
