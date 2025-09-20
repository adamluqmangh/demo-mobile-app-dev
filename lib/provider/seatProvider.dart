import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/cinemaSeatModel.dart';

class SeatProvider with ChangeNotifier {
  final _firebaseDb = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        "https://cinema-project-74985-default-rtdb.asia-southeast1.firebasedatabase.app/",
  ).ref("cinemaSeats");

  Map<String, Seat> _seats = {};
  Map<String, Seat> get seats => _seats;

  Timer? _seatTimer;

  SeatProvider() {
    _seatListener();
    _seatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      releaseSeats();
    });
  }

  void _seatListener() {
    _firebaseDb.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        _seats = data.map((key, value) {
          return MapEntry(
              key, Seat.fromJson(Map<String, dynamic>.from(value), key));
        });
        notifyListeners();
      }
    });
  }

  void toggleSelect(String seatId) {
    final seat = _seats[seatId];
    if (seat != null && seat.seatStatus == "available") {
      _seats[seatId] = seat.seatSelectStatus(isSelected: !seat.isSeatSelected);
      notifyListeners();
    }
  }

  Future<void> proceedToBooking() async {
    final now = DateTime.now();
    final selectedSeats = _seats.values.where((s) => s.isSeatSelected).toList();

    for (final seat in selectedSeats) {
      final seatRef = _firebaseDb.child(seat.seatId);
      final snapshot = await seatRef.get();

      if (!snapshot.exists) {
        await seatRef.set({
          'seatStatus': 'locked',
          'lockedDuration':
              now.add(const Duration(minutes: 2)).toIso8601String(),
        });
        continue;
      }

      final data = Map<String, dynamic>.from(snapshot.value as Map);
      final status = data['seatStatus'] ?? 'available';

      if (status == 'available') {
        await seatRef.update({
          'seatStatus': 'locked',
          'lockedDuration':
              now.add(const Duration(minutes: 2)).toIso8601String(),
        });
      }
    }

    notifyListeners();
  }

  void cancelSelection() {
    _seats = _seats.map((key, seat) {
      return MapEntry(key, seat.seatSelectStatus(isSelected: false));
    });
    notifyListeners();
  }

  void releaseSeats() {
    final now = DateTime.now();
    for (var seat in _seats.values) {
      if (seat.seatStatus == "locked" &&
          seat.lockedDuration != null &&
          seat.lockedDuration!.isBefore(now)) {
        _firebaseDb.child(seat.seatId).update({
          'seatStatus': 'available',
          'lockedDuration': null,
        });
      }
    }
  }

  @override
  void dispose() {
    _seatTimer?.cancel();
    super.dispose();
  }
}