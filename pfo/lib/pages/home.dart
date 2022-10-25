import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfo/classes/dados.dart';
import 'package:pfo/pages/cadastrarHorta.dart';
import 'package:pfo/pages/editarHorta.dart';
import 'package:pfo/pages/hortaDados.dart';
import 'package:provider/provider.dart';
import '../controller/pagina.controller.dart';
import 'homeAlertas.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HortaIno"),
        centerTitle: true,
        backgroundColor: const Color(0xFF1DBAF3),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: const ListBuilder()),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0FA9E1),
              ),
              child: Text(
                'Hortaino',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.category_outlined,
                color: Colors.black,
              ),
              title: const Text('Cadastrar Alertas'),
              onTap: () => _alertasHome(),
            ),
            const ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text('Configurações'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _cadastrarHortaPage();
        },
        label: const Text('Cadastrar Horta'),
        icon: const Icon(Icons.add_circle_outlined),
        backgroundColor: const Color(0xFF00ADFF),
      ),
    );
  }

  void _cadastrarHortaPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const CadastrarHorta())));
  }

  void _alertasHome() {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const HomeAlertas())));
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({Key? key}) : super(key: key);

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ControlarEstado>(context);

    return Observer(
      builder: (BuildContext context) => StreamBuilder(
          stream: FirebaseFirestore.instance.collection('hortas').snapshots(),
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
            Dados.ds = snapshot.data?.docs[0];
            return ListView(
              children: snapshot.data!.docs.map((e) {
                return Card(
                  child: ListTile(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HortaDados(e)))),
                    },
                    visualDensity: VisualDensity.standard,
                    title: Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      "Nome: " + e['nome'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(e["hortalica"]),
                    leading: const Icon(Icons.add_business_sharp,
                        size: 30, color: Colors.blue),
                    trailing: Wrap(
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
                                      'Deseja Realmente Remover a Horta/Estufa'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Não'),
                                      child: const Text('Não'),
                                    ),
                                    TextButton(
                                        child: const Text('Sim'),
                                        onPressed: () async {
                                          await store.removerHorta(e);
                                          Navigator.of(context).pop();
                                        }),
                                  ],
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.highlight_remove_rounded,
                              size: 35,
                              color: Color.fromARGB(255, 212, 45, 33),
                            )),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => EditarHorta(e))));
                          },
                          child: const Icon(
                            Icons.edit_note_sharp,
                            size: 35,
                            color: Colors.blue,
                          ),
                        ),
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
