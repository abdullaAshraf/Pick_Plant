import 'package:flutter/material.dart';
import '../models/plant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PlantDetails extends StatelessWidget {
  final Plant plant;

  PlantDetails({Key key, this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Color(0xFF34A163),
              Color(0xFF39975F)
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                    child: Text(
                      "Details: ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700),
                    ))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.thermometerQuarter,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                plant.temperature["min"].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "°C",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                " | " + plant.temperature["max"].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "°C",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.tint,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                plant.airHumidity["min"].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "%",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                " | " + plant.airHumidity["max"].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "%",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  Icons.wb_sunny,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                plant.light["min"].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "m",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                " | " + plant.light["max"].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                "m",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.stopwatch,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                plant.watering.toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                " hours",
                                style:
                                TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.leaf,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                plant.lifespan.toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                " years",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.paw,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                (plant.toxic ? "Non-p" : "P") + "et-friendly",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 26),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.arrowsAltV,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                plant.maxGrowth["height"].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                " cm",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.arrowsAltH,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                plant.maxGrowth["diameter"].toString(),
                                style:
                                    TextStyle(color: Colors.white, fontSize: 30),
                              ),
                              Text(
                                " cm",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    child: Icon(
                      Icons.texture,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    plant.soil.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0))),
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Row(
                  children: <Widget>[
                    CachedNetworkImage(
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      imageUrl: plant.image,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(plant.name,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black)),
                          Text(plant.category,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black54))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /*
                        child: IconButton(
                        icon: new Icon(Icons.link, size: 35,),
                        onPressed: _launchURL,
                      ),
   */

  _launchURL() async {
    String url = plant.url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
