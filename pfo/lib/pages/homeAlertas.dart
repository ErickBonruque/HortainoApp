// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/pagina.controller.dart';
import 'cadastrarAlertas.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeAlertas extends StatefulWidget {
  const HomeAlertas({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeAlertasState createState() => _HomeAlertasState();
}

class _HomeAlertasState extends State<HomeAlertas> {
  String dropdownValue = 'Padrão';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alertas"),
        backgroundColor: const Color(0xFF1DBAF3),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _cadastrarAlertasPage();
        },
        label: const Text('Cadastrar Alerta'),
        icon: const Icon(Icons.add_circle_outlined),
        backgroundColor: const Color(0xFF00ADFF),
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: const ListViewAlerta()),
    );
  }
  void _cadastrarAlertasPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => const CadastrarAlerta())));
  }
}

class ListViewAlerta extends StatefulWidget {
  const ListViewAlerta({Key? key}) : super(key: key);

  @override
  State<ListViewAlerta> createState() => _ListViewAlertaState();
}

class _ListViewAlertaState extends State<ListViewAlerta> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ControlarEstado>(context);

    return Observer(
      builder: (BuildContext context) => StreamBuilder(
          stream: FirebaseFirestore.instance.collection('alertas').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((e) {
                return Card(
                  child: ListTile(
                    visualDensity: VisualDensity.standard,
                    title: Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      "Nome: " + e['nome'],
                      style: const TextStyle(fontSize: 18),
                    ),
                    leading: const Icon(Icons.dangerous,
                        size: 30, color: Colors.blue),
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(
                                    'Cuidado',
                                    style: TextStyle(
                                        color:
                                        Color.fromARGB(255, 212, 45, 33)),
                                  ),
                                  content: const Text(
                                      'Deseja Realmente Remover o Alerta'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Não'),
                                      child: const Text('Não'),
                                    ),
                                    TextButton(
                                        child: const Text('Sim'),
                                        onPressed: () {
                                          store.removerAlerta(e);
                                          Navigator.of(context).pop();
                                        }),
                                  ],
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.highlight_remove_rounded,
                              size: 40,
                              color: Color.fromARGB(255, 212, 45, 33),
                            )),
                        // icon-1
                        // icon-2
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}

