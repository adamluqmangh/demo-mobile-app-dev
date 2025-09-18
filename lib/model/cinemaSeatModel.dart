class Seat {
  final String seatId;
  final String seatStatus;
  final DateTime? lockedDuration;

  Seat({
    required this.seatId, 
    required this.seatStatus,
    required this.lockedDuration
  });

  factory Seat.fromJson(Map<String, dynamic> json, String seatId) {
    return Seat(
      seatId: seatId,
      seatStatus: json['seatStatus'] ?? "available", 
      lockedDuration: json['lockedDuration'] != null ? DateTime.tryParse(json ['lockedDuration']) : null,
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'seatStatus': seatStatus,
      'lockedDuration': lockedDuration?.toIso8601String()
    };
  }
}