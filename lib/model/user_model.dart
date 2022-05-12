class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondname;

  UserModel({this.uid, this.email, this.firstName, this.secondname});

  //data from server

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondname: map['secondname'],
    );
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondname': secondname,
    };
  }
}
