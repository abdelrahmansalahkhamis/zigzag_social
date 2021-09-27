class PostModel {
  String? name;
  String? uId;
  String? image;
  String? text;
  String? dateTime;
  String? postImage;

  PostModel(this.name, this.text, this.uId, this.image, this.dateTime,
      this.postImage);

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postImage = json['postImage'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'text': text,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
    };
  }
}
