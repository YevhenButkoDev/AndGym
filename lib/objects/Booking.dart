class Booking {
  final int id;
  final String time;
  final int status;

  Booking({
    required this.id,
    required this.time,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      time: json['time'],
      status: json['status'],
    );
  }
}