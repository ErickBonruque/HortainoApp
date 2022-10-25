// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CadastrarConexao extends StatefulWidget {
  const CadastrarConexao({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CadastrarConexaoState createState() => _CadastrarConexaoState();
}

class _CadastrarConexaoState extends State<CadastrarConexao> {
  String dropdownValue = 'Padrão';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Horta"),
        backgroundColor: const Color(0xFF1DBAF3),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
        child: Column(children: [
          const TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                labelText: "Endereço",
                labelStyle: TextStyle(fontSize: 20)),
          ),
          const SizedBox(
            height: 30,
          ),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Nome bd", labelStyle: TextStyle(fontSize: 18)),
          ),
          const SizedBox(
            height: 30,
          ),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Porta", labelStyle: TextStyle(fontSize: 18)),
          ),
          const SizedBox(
            height: 30,
          ),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Senha", labelStyle: TextStyle(fontSize: 18)),
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
                  onPressed: () {},
                  child: const Text('Conectar'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
