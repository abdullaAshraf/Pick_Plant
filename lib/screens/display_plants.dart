import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../httpService.dart';
import '../screens/plant_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class PlantsSuggestions extends StatefulWidget {
  final Plant formData;

  PlantsSuggestions({Key key, @required this.formData}) : super(key: key);

  @override
  _PlantsSuggestionsState createState() => _PlantsSuggestionsState();
}

class _PlantsSuggestionsState extends State<PlantsSuggestions> {
  Future<List<Plant>> plants;
  HttpService httpService = new HttpService();

  @override
  void initState() {
    super.initState();
    plants = httpService.postForm(widget.formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommended Plants',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.grey[700],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: FutureBuilder<List<Plant>>(
                  future: plants,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Plant plant = snapshot.data[index];
                          return Card(
                            elevation: 5,
                            child: new InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PlantDetails(
                                              plant: plant),
                                    ),
                                  );
                                },
                                child: Container(
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
                                  height: 100,
                                  child: Row(
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        imageUrl: plant.image,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        height: 100,
                                        width: 90,
                                        fit: BoxFit.fill,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(plant.name,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white)),
                                            Text(plant.category,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white60))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 10, 0),
                                          child: Container(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                  (plant.match * 100)
                                                          .toStringAsFixed(0) +
                                                      "%",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              FlatButton(
                onPressed: _showDialog,
                child: Text('Suggest more plants',
                    style: TextStyle(color: Colors.black54, fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Plant Name', hintText: 'eg. Areca Palm'),
                onChanged: (String val) => widget.formData.name = val,
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Submit'),
              onPressed: () {
                httpService.suggestPlant(widget.formData);
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
