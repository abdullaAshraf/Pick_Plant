import 'package:flutter/material.dart';
import '../models/plant.dart';
import './display_plants.dart';
import 'package:light/light.dart';
import 'dart:async';
import '../httpService.dart';
import 'dart:math';

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final _formKey = GlobalKey<FormState>();
  final _plant = Plant();
  final HttpService httpService = new HttpService();
  String dropdownValue = 'Any';
  Light _light;
  StreamSubscription _subscription;
  bool lightDetection = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Pick Plant Form')),
        body: Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '   Dimensions   ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[400]),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'Diamater:',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Color(0xFF39975F),
                                    activeTrackColor: Color(0xFF34A163),
                                    inactiveTrackColor: Colors.grey,
                                  ),
                                  child: Slider(
                                    min: 0.0,
                                    max: 100.0,
                                    divisions: 20,
                                    label: _plant.maxGrowth[Plant.DIAMETER]
                                            .toString() +
                                        " cm",
                                    onChanged: (val) {
                                      setState(() =>
                                          _plant.maxGrowth[Plant.DIAMETER] =
                                              val.round());
                                    },
                                    value: _plant.maxGrowth[Plant.DIAMETER]
                                        .toDouble(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'Height:',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Color(0xFF39975F),
                                    activeTrackColor: Color(0xFF34A163),
                                    inactiveTrackColor: Colors.grey,
                                  ),
                                  child: Slider(
                                    min: 0.0,
                                    max: 300.0,
                                    divisions: 30,
                                    label: _plant.maxGrowth[Plant.HEIGHT]
                                            .toString() +
                                        " cm",
                                    onChanged: (val) {
                                      setState(() =>
                                          _plant.maxGrowth[Plant.HEIGHT] =
                                              val.round());
                                    },
                                    value: _plant.maxGrowth[Plant.HEIGHT]
                                        .toDouble(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '   Weather   ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[400]),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'Temperature:',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Color(0xFF39975F),
                                    activeTrackColor: Color(0xFF34A163),
                                    inactiveTrackColor: Colors.grey,
                                  ),
                                  child: RangeSlider(
                                    min: 0.0,
                                    max: 50.0,
                                    divisions: 50,
                                    labels: RangeLabels(
                                        _plant.temperature[Plant.MIN]
                                                .toString() +
                                            " °C",
                                        _plant.temperature[Plant.MAX]
                                                .toString() +
                                            " °C"),
                                    onChanged: (val) {
                                      setState(() {
                                        _plant.temperature[Plant.MIN] =
                                            val.start.round();
                                        _plant.temperature[Plant.MAX] =
                                            val.end.round();
                                      });
                                    },
                                    values: RangeValues(
                                        _plant.temperature[Plant.MIN]
                                            .toDouble(),
                                        _plant.temperature[Plant.MAX]
                                            .toDouble()),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'Humidity:',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Color(0xFF39975F),
                                    activeTrackColor: Color(0xFF34A163),
                                    inactiveTrackColor: Colors.grey,
                                  ),
                                  child: RangeSlider(
                                    min: 0.0,
                                    max: 100.0,
                                    divisions: 100,
                                    labels: RangeLabels(
                                        _plant.airHumidity[Plant.MIN]
                                                .toString() +
                                            " %",
                                        _plant.airHumidity[Plant.MAX]
                                                .toString() +
                                            " %"),
                                    onChanged: (val) {
                                      setState(() {
                                        _plant.airHumidity[Plant.MIN] =
                                            val.start.round();
                                        _plant.airHumidity[Plant.MAX] =
                                            val.end.round();
                                      });
                                    },
                                    values: RangeValues(
                                        _plant.airHumidity[Plant.MIN]
                                            .toDouble(),
                                        _plant.airHumidity[Plant.MAX]
                                            .toDouble()),
                                  ),
                                ),
                              ),
                              FlatButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: detectWeather,
                                child: Text("auto",
                                    style: TextStyle(
                                        color: Color(0xFF39975F),
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '   Lifestyle   ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[400]),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'Lifespan:',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Color(0xFF39975F),
                                    activeTrackColor: Colors.grey,
                                    inactiveTrackColor: Color(0xFF34A163),
                                  ),
                                  child: Slider(
                                    min: 0.0,
                                    max: 50.0,
                                    divisions: 50,
                                    label: _plant.lifespan.round().toString() +
                                        " years",
                                    onChanged: (val) {
                                      setState(() => _plant.lifespan = val);
                                    },
                                    value: _plant.lifespan,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'Max absence:',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Color(0xFF39975F),
                                    activeTrackColor: Color(0xFF34A163),
                                    inactiveTrackColor: Colors.grey,
                                  ),
                                  child: Slider(
                                    min: 0.0,
                                    max: 365.0,
                                    divisions: 365,
                                    label: _plant.watering.toString() + " days",
                                    onChanged: (val) {
                                      setState(
                                          () => _plant.watering = val.round());
                                    },
                                    value: _plant.watering.toDouble(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '   Environment   ',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[400]),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Text(
                                  'Sun light at:',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    thumbColor: Color(0xFF39975F),
                                    activeTrackColor: Color(0xFF34A163),
                                    inactiveTrackColor: Colors.grey,
                                  ),
                                  child: Slider(
                                    min: 0.0,
                                    max: 5.0,
                                    divisions: 15,
                                    label: _plant.light[Plant.MIN]
                                            .toStringAsFixed(2) +
                                        " m",
                                    onChanged: (val) {
                                      setState(
                                          () => _plant.light[Plant.MIN] = val);
                                    },
                                    value: _plant.light[Plant.MIN],
                                  ),
                                ),
                              ),
                              FlatButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {
                                  if (lightDetection)
                                    stopListening();
                                  else
                                    startListening();
                                  setState(() {
                                    lightDetection = !lightDetection;
                                  });
                                },
                                color: (!lightDetection
                                    ? Colors.white
                                    : Color(0xFF39975F)),
                                child: Text(
                                    "auto " + (!lightDetection ? "off" : "on"),
                                    style: TextStyle(
                                        color: (lightDetection
                                            ? Colors.white
                                            : Color(0xFF39975F)),
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Soil Type:    ",
                                  style: TextStyle(fontSize: 16)),
                              Expanded(
                                child: new Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: Colors.white,
                                  ),
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    underline: Container(
                                      height: 2,
                                      color: Color(0xFF39975F),
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'Any',
                                      'Clay',
                                      'Loam',
                                      'Peaty',
                                      'Sandy',
                                      'Silty',
                                      'Chalky',
                                      'Soil-less'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              FlatButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {},
                                child: Text("auto detect",
                                    style: TextStyle(
                                        color: Color(0xFF39975F),
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                          SwitchListTile(
                              title: Align(
                                child: new Text("Pet Owner (Dogs - Cats)",
                                    style: TextStyle(fontSize: 16)),
                                alignment: Alignment(-1.31, 0),
                              ),
                              value: _plant.toxic,
                              activeColor: Color(0xFF39975F),
                              onChanged: (bool val) =>
                                  setState(() => _plant.toxic = val)),
                          RaisedButton(
                              color: Color(0xFF39975F),
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 0),
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PlantsSuggestions(formData: _plant),
                                    ),
                                  );
                                }
                              },
                              child: Text('Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20))),
                        ])))));
  }

  void onData(int luxValue) async {
    print("Lux value from Light Sensor: $luxValue");
    setState(() {
      luxValue = max(luxValue, 100);
      luxValue = min(luxValue, 1000);
      _plant.light["min"] = 5 - ((luxValue - 100) / 900 * 5);
    });
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  void detectWeather() async {
    dynamic weather = await httpService.getWeather();
    if (weather != null)
      setState(() {
        _plant.temperature["min"] = weather["minTemperature"];
        _plant.temperature["max"] = weather["maxTemperature"];
        _plant.airHumidity["min"] = weather["minHumidity"];
        _plant.airHumidity["max"] = weather["maxHumidity"];
      });
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
