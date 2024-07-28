class UserModel {
  String? email;
  String? role;
  String? uid;
  String? name;
  String? phone;

  UserModel({this.uid, this.email, this.role, this.name, this.phone});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      role: map['role'],
      name: map['name'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
      'name': name,
      'phone': phone,
    };
  }
}

