import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location
  String? time; // time
  String flag; // flag of the Country
  String url; // location url for the endpoint
  bool? isDayTime; // to check if it is Day time or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    // make the request
    String currentTime = "http://worldtimeapi.org/api/timezone/$url";

    try {
      Response response = await get(Uri.parse(currentTime));

      Map data = jsonDecode(response.body);

      // get data from the endpoint
      String datetime = data["datetime"];
      String offset = data["utc_offset"].substring(1, 3);

      // print(datetime);
      // print(offset);

      // create a Date Time object
      DateTime now = DateTime.parse(datetime);
      // now = now.add(Duration(hours: int.parse(offset)));
      // print(now);

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      time = "Could not get time data";
    }
  }
}

WorldTime instance = WorldTime(
    location: "Berlin", flag: "img/Germany.png", url: "Europe/Berlin");
