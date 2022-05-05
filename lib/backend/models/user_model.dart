class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.orderCount});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        id: jsonData['id'],
        name: jsonData['f_name'],
        email: jsonData['email'],
        phone: jsonData['phone'],
        orderCount: jsonData['order_count']);
  }
}
