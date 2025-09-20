class Seat {
  final String seatId;
  final String seatStatus;
  final DateTime? lockedDuration;
  final bool isSeatSelected;

  Seat({
    required this.seatId, 
    required this.seatStatus,
    required this.lockedDuration,
    this.isSeatSelected = false
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

  Seat seatSelectStatus({bool? isSelected}) {
    return Seat(
      seatId: seatId,
      seatStatus: seatStatus,
      lockedDuration: lockedDuration,
      isSeatSelected: isSelected ?? this.isSeatSelected,
    );
  }
}