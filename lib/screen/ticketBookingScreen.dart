import 'package:adamcinemaapp/dataService/cinemaHallService.dart';
import 'package:flutter/material.dart';
import '../dataService/locationService.dart';


class TicketBookingScreen extends StatefulWidget {
  const TicketBookingScreen({super.key});

  @override
  State<TicketBookingScreen> createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  List<String> locations = [];
  List<String> cinemaHalls = [];
  String? selectedLocation;
  String? selectedCinemaHall;

  @override
  void initState() {
    super.initState();
    fetchLocations();
    fetchCinemaHall();
  }

  Future<void> fetchLocations() async {
    final data = await LocationService.loadLocations();
    setState(() {
      locations = data;
      selectedLocation = locations.isNotEmpty ? locations[0] : null;
    });
  }

  Future<void> fetchCinemaHall() async {
    final data = await CinemaHallService.loadCinemaHall();
    setState(() {
      cinemaHalls = data;
      selectedCinemaHall = cinemaHalls.isNotEmpty ? cinemaHalls[0] : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Ticket Booking"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Where would you like to see the movies? Kindly select as appropriate",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 170,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,                    children: const [
                      Text(
                        "Tickets from",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "RM20 - RM40",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  height: 100,
                  width: 170,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Tickets from",
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "RM20 - RM40",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Location",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedLocation,
                  items: locations.map((location){
                    return DropdownMenuItem(
                      value: location,
                      child: Text(location),
                      );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedLocation = value;
                    });
                  }),
              ),
            ),
            ),
            Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Cinema Location",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCinemaHall,
                  items: cinemaHalls.map((cinemaHall){
                    return DropdownMenuItem(
                      value: cinemaHall,
                      child: Text(cinemaHall),
                      );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedCinemaHall = value;
                    });
                  }),
              ),
            ),
            )
        ],
      ),
    );
  }
}