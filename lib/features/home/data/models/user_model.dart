class UserModel {
  final int id;
  final String? uniqueId;
  final String? name;
  final String? phone;
  final String? image;
  final int? coins;
  final dynamic credit;
  final dynamic debit;

  UserModel({
    required this.id,
    this.uniqueId,
    this.name,
    this.phone,
    this.image,
    this.coins,
    this.credit,
    this.debit,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      uniqueId: json['unique_id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
      coins: json['coins'],
      credit: json['credit'],
      debit: json['debit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unique_id': uniqueId,
      'name': name,
      'phone': phone,
      'image': image,
      'coins': coins,
      'credit': credit,
      'debit': debit,
    };
  }
}
