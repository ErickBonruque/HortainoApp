// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfo/classes/dados.dart';
import 'package:pfo/controller/pagina.controller.dart';
import 'package:provider/provider.dart';
import '../classes/alerta.dart';

class CadastrarAlerta extends StatefulWidget {
  const CadastrarAlerta({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CadastrarAlertaState createState() => _CadastrarAlertaState();
}

class _CadastrarAlertaState extends State<CadastrarAlerta> {
  User? usuario = FirebaseAuth.instance.currentUser;
  TextEditingController nome = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController umidade = TextEditingController();
  TextEditingController temperatura = TextEditingController();
  late AsyncSnapshot<QuerySnapshot> snapshot;
  String dropdownValue = Dados.ds!["nome"].toString();
  String idHortaDrop = Dados.ds!.id.toString();
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ControlarEstado>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Alerta"),
        backgroundColor: const Color(0xFF1DBAF3),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 30),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: nome,
              keyboardType: TextInputType.name,
              onSubmitted: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                  labelText: "Nome do Alerta",
                  labelStyle: TextStyle(fontSize: 20)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: desc,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: "Descrição", labelStyle: TextStyle(fontSize: 18)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: umidade,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Umidade", labelStyle: TextStyle(fontSize: 18)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: temperatura,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Temperatura",
                  labelStyle: TextStyle(fontSize: 18)),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('hortas').where("idUsuario", isEqualTo: usuario?.uid).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 0, 71, 129)),
                      ),
                    );
                  }
                  return DropdownButton<String>(
                    items: snapshot.data!.docs.map((e) {
                        return DropdownMenuItem<String>(
                          value: e["nome"].toString(),
                          child: Text(e["nome"]),
                        );
                    }).toList(),
                    value: dropdownValue,
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    elevation: 16,
                    style:
                        const TextStyle(color: Color(0xFF1DBAF3), fontSize: 15),
                    underline: Container(
                      height: 2,
                      color: const Color.fromARGB(255, 0, 86, 117),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        QuerySnapshot query = FirebaseFirestore.instance
                            .collection("hortas")
                            .where("nome", isEqualTo: newValue)
                            .get() as QuerySnapshot<Object?>;
                        for (var element in query.docs) {
                          idHortaDrop = element.get("id");
                        }
                      });
                    },
                  );
                }),
          ),
          const SizedBox(height: 60.0),
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
                        right: 80, left: 80, top: 15, bottom: 15),
                    primary: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Alerta a = Alerta(nome.text, desc.text, umidade.text,
                        temperatura.text, dropdownValue, idHortaDrop);
                    store.addAlerta(a);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cadastrar Alerta'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
