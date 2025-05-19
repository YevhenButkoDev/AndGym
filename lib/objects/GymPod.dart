class GymPod {
  final int id;
  final String location;
  final double price;

  GymPod({
    required this.id,
    required this.location,
    required this.price,
  });

  factory GymPod.fromJson(Map<String, dynamic> json) {
    return GymPod(
      id: json['id'],
      location: json['location'],
      price: (json['price'] as num).toDouble(),
    );
  }
}