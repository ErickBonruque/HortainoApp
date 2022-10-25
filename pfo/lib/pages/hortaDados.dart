// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfo/pages/tabBarView/tabBarView1.dart';
import 'package:pfo/pages/tabBarView/tabBarView2.dart';

class HortaDados extends StatefulWidget {
  final DocumentSnapshot e;
  const HortaDados(this.e, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HortaDadosState createState() => _HortaDadosState();
}

class _HortaDadosState extends State<HortaDados> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: Color.fromARGB(0, 8, 99, 133),
            tabs: [
              Text(
                'Dados Atuais',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Historico De Dados',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          title: Text(widget.e['nome'].toString()),
          backgroundColor: const Color(0xFF1DBAF3),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
        ),
        body: const TabBarView(
          children: [
            TabBarView1(),
            TabBarView2(),
          ],
        ),
      ),
    );
  }
}
