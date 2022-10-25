// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;

class TabBarView2 extends StatefulWidget {
  const TabBarView2({Key? key}) : super(key: key);

  @override
  State<TabBarView2> createState() => _TabBarView2State();
}

class _TabBarView2State extends State<TabBarView2> {
  DateTime date = DateTime(2022, 08, 23);
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
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Filtrar Por Datas',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 30),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50, right: 50, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Data Inicio: ", style: TextStyle(fontSize: 20),),
                ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1DBAF3),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            right: 30, left: 30),
                        primary: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () async {
                      },
                      child: const Text('Selecione uma data', style: TextStyle(fontSize: 12),),
                    ),
                  ],
                ),
              ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50, right: 50, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Data Inicio: ", style: TextStyle(fontSize: 20),),
                ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1DBAF3),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            right: 30, left: 30),
                        primary: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () async {
                      },
                      child: const Text('Selecione uma data', style: TextStyle(fontSize: 12),),
                    ),
                  ],
                ),
              ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1DBAF3),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(
                            right: 100, left: 100, top: 15, bottom: 15),
                        primary: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                      },
                      child: const Text('Filtrar'),
                    ),
                  ],
                ),
              ),
          ),
          Container(
                margin: const EdgeInsets.only(left: 40, top: 50),
                alignment: Alignment.topLeft,
                child: const Text("Dados Filtrados: ", style: TextStyle(fontSize: 25),)
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
      ));
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

