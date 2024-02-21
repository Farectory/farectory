import 'package:charts_flutter/flutter.dart' as charts;

class BarChartData {
  String country;
  int hectares;
  final charts.Color color;

  BarChartData({
    required this.country,
    required this.hectares,
    required this.color,
  });
}