class Packages {
  List<Data>? data;

  Packages({this.data});

  Packages.fromJson(Map<String, dynamic> json) {
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
  String? pId;
  String? pImage;
  String? pImage1;
  String? pImage2;
  String? pName;
  String? country;
  String? state;
  String? pDescription;

  Data(
      {this.pId,
        this.pImage,
        this.pImage1,
        this.pImage2,
        this.pName,
        this.country,
        this.state,
        this.pDescription});

  Data.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    pImage = json['p_image'];
    pImage1 = json['p_image1'];
    pImage2 = json['p_image2'];
    pName = json['p_name'];
    country = json['country'];
    state = json['state'];
    pDescription = json['p_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_id'] = this.pId;
    data['p_image'] = this.pImage;
    data['p_image1'] = this.pImage1;
    data['p_image2'] = this.pImage2;
    data['p_name'] = this.pName;
    data['country'] = this.country;
    data['state'] = this.state;
    data['p_description'] = this.pDescription;
    return data;
  }
}
