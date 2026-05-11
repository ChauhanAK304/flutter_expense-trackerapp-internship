class UserModel {
  late final String id;
  late final String name;
  late final int phone;
  late final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email});

  /// map to object
  factory UserModel.fromMap(Map<String, dynamic> map, String docId){
    return UserModel(
        id: map["id"],
        name: map["name"]??'',
        phone: map["phone"]?? 0,
        email: map["email"]??'');
     }

  /// object to map
Map<String, dynamic> toMap() {
    return {
      "id" : id,
      "name" : name,
      "phone" : phone,
      "email" : email };
}}