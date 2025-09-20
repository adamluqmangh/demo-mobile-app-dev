import 'package:adamcinemaapp/model/cinemaSeatModel.dart';
import 'package:adamcinemaapp/provider/seatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatGrid extends StatelessWidget {
  const SeatGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final seats = context.watch<SeatProvider>().seats;

    final Map<String, List<Seat>> seatsByRow = {};
    for (var seat in seats.values) {
      final row = seat.seatId[0]; 
      seatsByRow.putIfAbsent(row, () => []).add(seat);
    }

    final sortedRows = seatsByRow.keys.toList()..sort();

    return Column(
      children: sortedRows.map((row) {
        final rowSeats = seatsByRow[row]!;

        rowSeats.sort((a, b) {
          final numA = int.tryParse(a.seatId.substring(1)) ?? 0;
          final numB = int.tryParse(b.seatId.substring(1)) ?? 0;
          return numA.compareTo(numB);
        });

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowSeats.map((seat) {
              Color color;
              Widget child;

              if (seat.isSeatSelected) {
                color = Colors.white;
                child = Text(seat.seatId,
                    style: const TextStyle(color: Colors.black, fontSize: 12));
              } else if (seat.seatStatus == "booked" ||
                  seat.seatStatus == "locked") {
                color = Colors.grey[850]!;
                child = const Icon(Icons.close, size: 16, color: Colors.white);
              } else {
                color = Colors.grey[850]!;
                child = Text(seat.seatId,
                    style: const TextStyle(color: Colors.white, fontSize: 12));
              }

              return GestureDetector(
                onTap: () {
                  if (seat.seatStatus == "available") {
                    context.read<SeatProvider>().toggleSelect(seat.seatId);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: child,
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
