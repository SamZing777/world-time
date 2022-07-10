import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    // print("Data: $data")

    String location = data["location"];
    String time = data["time"];
    String bgImg = data["isDayTime"] ? "img/day.png" : "img/night.png";
    Color bgColor = data["isDayTime"] ? Colors.blueAccent : Colors.indigoAccent;

    void loadOtherScreens() async {
      dynamic result = await Navigator.pushNamed(context, '/location');

      if (result != null) {
        setState(() {
          data = {
            "time": result["time"],
            "location": result["location"],
            "isDayTime": result["isDayTime"],
            "flag": result["flag"]
          };
        });
      }
    }

    return (Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bgImg), fit: BoxFit.cover)),
                child: Column(
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.fromLTRB(0, 120.0, 0, 0)),
                    TextButton.icon(
                        onPressed: () {
                          loadOtherScreens();
                        },
                        icon: const Icon(
                          Icons.edit_location,
                          color: Color.fromARGB(155, 255, 255, 255),
                        ),
                        label: const Text(
                          "Choose location",
                          style: TextStyle(
                              color: Color.fromARGB(155, 255, 255, 255)),
                        )),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          location,
                          style: const TextStyle(
                              fontSize: 28.0,
                              letterSpacing: 2.0,
                              color: Color.fromARGB(155, 255, 255, 255)),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      time,
                      style: const TextStyle(
                          fontSize: 65.0,
                          color: Color.fromARGB(155, 255, 255, 255)),
                    )
                  ],
                )))));
  }
}
