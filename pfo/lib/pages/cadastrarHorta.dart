// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pfo/pages/cadastrarConexao.dart';
import 'package:pfo/pages/home.dart';
import 'package:provider/provider.dart';
import '../classes/horta.dart';
import '../controller/pagina.controller.dart';

class CadastrarHorta extends StatefulWidget {
  const CadastrarHorta({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CadastrarHortaState createState() => _CadastrarHortaState();
}

class _CadastrarHortaState extends State<CadastrarHorta> {
  String dropdownValue = 'Padrão';
  TextEditingController nome = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ControlarEstado>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Horta"),
        backgroundColor: const Color(0xFF1DBAF3),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
        child: Column(children: [
          TextField(
            controller: nome,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                labelText: "Nome da Horta/Estufa",
                labelStyle: TextStyle(fontSize: 20)),
          ),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: desc,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                labelText: "Descrição da Horta/Estufa", labelStyle: TextStyle(fontSize: 18)),
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
           margin: const EdgeInsets.only(bottom: 90, top: 5),
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
                        right: 50, left: 50, top: 15, bottom: 15),
                    primary: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    _cadastrarConexaoPage();
                  },
                  child: const Text('Configurar Conexão'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
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
                  //Salvar Dados da Horta
                  onPressed: () {
                    Horta h = Horta(nome.text, desc.text, dropdownValue, null);
                    store.addHorta(h);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Home())));
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }


  void _cadastrarConexaoPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const CadastrarConexao())));
  }
}
