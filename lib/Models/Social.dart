class Social {
  List<Data>? data;

  Social({this.data});

  Social.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? firstName;
  String? email;
  String? photo;
  String? postId;
  String? memories;
  String? title;
  String? description;

  Data(
      {this.firstName,
        this.email,
        this.photo,
        this.postId,
        this.memories,
        this.title,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    email = json['email'];
    photo = json['photo'];
    postId = json['post_id'];
    memories = json['memories'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['post_id'] = this.postId;
    data['memories'] = this.memories;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
