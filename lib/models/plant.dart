class Plant {
  static String HEIGHT = 'height';
  static String DIAMETER = 'diameter';
  static String MIN = 'min';
  static String MAX = 'max';

  Plant();

  String name;
  String url;
  String category;
  bool toxic = false;
  Map<String, int> maxGrowth = {
    "diameter" : 40,
    "height" : 30,
  };
  Map<String, int> temperature = {
    "min" : 4,
    "max" : 24,
  };
  Map<String, int> airHumidity = {
    "min" : 25,
    "max" : 40,
  };
  Map<String, double> light = {
    "min" : 2.toDouble(),
    "max" : 1.toDouble(),
  };
  double lifespan = 3;
  String soil;
  int watering = 2;
  int lightDuration;
  String image;
  double match;

  Plant.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'],
        category = json['category'],
        maxGrowth = {
          'diameter': json['maxGrowth'][DIAMETER],
          'height': json['maxGrowth'][HEIGHT],
        },
        temperature = {
          'min': json['temperature'][MIN],
          'max': json['temperature'][MAX],
        },
        airHumidity = {
          'min': json['airHumidity'][MIN],
          'max': json['airHumidity'][MAX],
        },
        light = {
          'min': json['light'][MIN].toDouble(),
          'max': json['light'][MAX].toDouble(),
        },
        soil = json['soil'],
        image = json['image'],
        watering = json['watering'],
        lightDuration = json['lightDuration'],
        lifespan = json['lifespan'].toDouble(),
        match = json['match'].toDouble()
  ;

  Map<String, dynamic> toJson() =>
      {
        'name':name,
        'maxGrowth': maxGrowth,
        'temperature': temperature,
        'airHumidity': airHumidity,
        'soil': soil,
        'watering': watering,
        'light': light,
        'toxic': toxic,
        'lifespan': lifespan,
      };

}