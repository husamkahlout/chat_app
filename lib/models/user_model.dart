class UserModel {
  String? userID;
  String? name;
  String? email;

  UserModel({this.userID, this.name, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['userID'] = userID;
    return data;
  }
}
