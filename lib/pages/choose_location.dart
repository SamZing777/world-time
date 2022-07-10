import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: "Accra", flag: "img/Ghana.png", url: "Africa/Accra"),
    WorldTime(location: "Cairo", flag: "img/Egypt.png", url: "Africa/Cairo"),
    WorldTime(
        location: "Nairobi", flag: "img/Kenya.jpg", url: "Africa/Nairobi"),
    WorldTime(
        location: "Jakarta", flag: "img/Indonesia.png", url: "Asia/Jakarta"),
    WorldTime(location: "Tokyo", flag: "img/Japan.png", url: "Asia/Tokyo"),
    WorldTime(
        location: "Sydney", flag: "img/Australia.png", url: "Australia/Sydney"),
    WorldTime(
        location: "Chicago", flag: "img/America.png", url: "America/Chicago"),
    WorldTime(
        location: "New York", flag: "img/America.png", url: "America/New_York"),
    WorldTime(
        location: "Berlin", flag: "img/Germany.png", url: "Europe/Berlin"),
    // WorldTime(location: "Italy", flag: "img/Italy.png", url: "Europe/Italy"),
    WorldTime(location: "Fiji", flag: "img/Fiji.png", url: "Pacific/Fiji")
  ];

  @override
  void initState() {
    super.initState();
  }

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    if (!mounted) return;
    // Navigate to Home screen
    Navigator.pop(context, {
      "location": instance.location,
      "flag": instance.flag,
      "time": instance.time,
      "isDayTime": instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Choose a location"),
          centerTitle: true,
          elevation: 0),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                  child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(locations[index].flag),
                ),
              )));
        },
      ),
    ));
  }
}
