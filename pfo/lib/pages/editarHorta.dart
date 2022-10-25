// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfo/pages/home.dart';
import 'package:provider/provider.dart';
import '../classes/horta.dart';
import '../controller/pagina.controller.dart';

// ignore: must_be_immutable
class EditarHorta extends StatefulWidget {
  final DocumentSnapshot e;
  EditarHorta(this.e, {Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _EditarHortaState createState() => _EditarHortaState();
}

class _EditarHortaState extends State<EditarHorta> {
  String dropdownValue = "Padrão";
  TextEditingController nome = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final store = Provider.of<ControlarEstado>(context);
    nome = TextEditingController(text: widget.e['nome'].toString());
    desc = TextEditingController(text: widget.e['descricao'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Editar ${widget.e['nome']}"),
        backgroundColor: const Color(0xFF1DBAF3),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(children: [
          TextFormField(
            controller: nome,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                labelText: "Nome da Horta/Estufa",
                labelStyle: TextStyle(fontSize: 20)),
            onChanged: (text) {},
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: desc,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                labelText: "Descrição da Horta/Estufa", labelStyle: TextStyle(fontSize: 18)),
            onChanged: (text) {},
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text("Tipo da cultura da Horta/Estufa", style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 109, 109, 109)
            ),),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: DropdownButton<String>(
              value: dropdownValue,
              dropdownColor: Colors.white,
              icon: const Icon(Icons.keyboard_arrow_down_sharp),
              elevation: 16,
              style: const TextStyle(color: Color(0xFF1DBAF3), fontSize: 15),
              underline: Container(
                height: 2,
                color: const Color.fromARGB(255, 0, 86, 117),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Padrão', 'Tomate', 'Alface', "Morango"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 90,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
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
                        right: 100, left: 100, top: 20, bottom: 20),
                    primary: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () async {
                    Horta horta = Horta(nome.text, desc.text, dropdownValue, null);
                    await store.updateHorta(horta, widget.e);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Home())));
                  },
                  child: const Text('Atualizar Horta'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}