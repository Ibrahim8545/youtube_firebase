class UserModel {
  final String name;
  final String email;
  final String phone;
  final String uid;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uid,
  });
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'phone': phone, 'uid': uid};
  }
}
