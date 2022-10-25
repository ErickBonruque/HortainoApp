// ignore_for_file: file_names
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;

class TabBarView1 extends StatefulWidget {
  const TabBarView1({Key? key}) : super(key: key);

  @override
  State<TabBarView1> createState() => _TabBarView1State();
}

class _TabBarView1State extends State<TabBarView1> {
  static double time = 0;

  TooltipBehavior? _tooltipBehavior;

  static ChartSeriesController? _chartSeriesController;

  static List<ChartData> chartData1 = <ChartData>[];
  static List<ChartData> chartData2 = <ChartData>[];
  static Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 40, top: 20, bottom: 20, right: 20),
              child: Row
              (children: [
                CircularPercentIndicator(
                  radius: 65,
                  lineWidth: 12,
                  progressColor: const Color(0xFF1DBAF3),
                  percent: 0.5,
                  center: const Text(
                    "50%",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.00),
                  child: Column(
                    children: const [
                      Text("Umiade", style: TextStyle(fontSize: 30),),
                      SizedBox(height: 30),
                      Text("26UR Umidade Solo", style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10),
                      Text("25°C Ambiente", style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, top: 30),
              alignment: Alignment.topLeft,
              child: const Text("Status: Normal", style: TextStyle(fontSize: 25),)
            ),
            Container(
              margin: const EdgeInsets.only(right: 30),
              width: 400,
              height: 2,
              color: const Color(0xFF1DBAF3),
            ),
            
            SfCartesianChart(
              legend: Legend(isVisible: false),
              tooltipBehavior: _tooltipBehavior,
              series: <LineSeries<ChartData, double>>[
                LineSeries<ChartData, double>(
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  name: 'NH3',
                  dataSource: chartData1,
                  color: const Color.fromRGBO(192, 108, 132, 1),
                  xValueMapper: (ChartData sales, _) => sales.tempo,
                  yValueMapper: (ChartData sales, _) => sales.umidade,
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: NumericAxis(
                title: AxisTitle(text: 'Tempo (s)'),
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 1,
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'Umidade (UR)'),
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                majorTickLines: const MajorTickLines(size: 0),
              ),
            ),
            SfCartesianChart(
              legend: Legend(isVisible: false),
              tooltipBehavior: _tooltipBehavior,
              series: <LineSeries<ChartData, double>>[
                LineSeries<ChartData, double>(
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  name: 'NH3',
                  dataSource: chartData1,
                  color: const Color.fromRGBO(192, 108, 132, 1),
                  xValueMapper: (ChartData sales, _) => sales.tempo,
                  yValueMapper: (ChartData sales, _) => sales.umidade,
                  enableTooltip: true,
                ),
              ],
              primaryXAxis: NumericAxis(
                title: AxisTitle(text: 'Tempo (s)'),
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 1,
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'Temperatura (C°)'),
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                majorTickLines: const MajorTickLines(size: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _tooltipBehavior = TooltipBehavior(enable: true);
      limpaGrafico();
      _timer =
          Timer.periodic(const Duration(milliseconds: 500), updateDataSource);
    });
    super.initState();
  }

  Future limpaGrafico() async {
    time = 0;
    _chartSeriesController = null;
  }

  updateDataSource(Timer timer) {
    if (time >= 60) {
      time = 0;

      if (mounted) {
        setState(() {
          chartData1 = <ChartData>[];
          chartData2 = <ChartData>[];
          ChartData origemChart = ChartData(0, 0);
          chartData1.add(origemChart);
          chartData2.add(origemChart);

          _chartSeriesController!.updateDataSource(
              removedDataIndexes: [0, 1, 2, 3, 4], addedDataIndex: 0);
        });
      }
    } else {
      chartData1.add(
        ChartData(
          double.parse((math.Random().nextDouble() * 10).toStringAsFixed(0)),
          time,
        ),
      );
      chartData2.add(
        ChartData(
          double.parse((math.Random().nextDouble() * 10).toStringAsFixed(0)),
          time,
        ),
      );

      if (chartData1.length > 5) {
        if (mounted) {
          setState(() {
            chartData1.removeAt(0);
            chartData2.removeAt(0);
            _chartSeriesController?.updateDataSource(
                removedDataIndex: 0, addedDataIndex: chartData1.length - 1);
          });
        }
      }
    }
    time++;
  }

  Future cancelaTimer() async {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Future dispose() async {
    chartData1 = <ChartData>[];
    chartData2 = <ChartData>[];
    time = 0;
    Future.delayed(Duration.zero, () async {
      await cancelaTimer().then((value) {});
    });
    super.dispose();
  }
}

class ChartData {
  late final double umidade;
  late final double tempo;

  ChartData(this.umidade, this.tempo);
}
