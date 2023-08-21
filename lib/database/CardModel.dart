class CardModel {
  final String id;
  final String name;
  final String job;
  final String web;
  final String email;
  final String telephone;
  final String mobile;
  final String address;
  final String photoUrl;
  final String logoUrl;
  final int userCard; // 0 = false, 1 = true

  const CardModel({
    required this.id,
    required this.name,
    required this.job,
    required this.web,
    required this.email,
    required this.telephone,
    required this.mobile,
    required this.address,
    required this.photoUrl,
    required this.logoUrl,
    required this.userCard,
  });
}