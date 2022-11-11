import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pfo/classes/dados.dart';
import 'package:pfo/pages/cadastrarHorta.dart';
import 'package:pfo/pages/editarHorta.dart';
import 'package:pfo/pages/hortaDados.dart';
import 'package:provider/provider.dart';
import '../controller/checagemLoginPage.dart';
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
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              title: const Text('Sair da Conta'),
              onTap: () async {
                await FirebaseAuth.instance
                    .signOut()
                    .then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChecagemLoginPage(),
                        )));
              },
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
  User? usuario = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ControlarEstado>(context);
    return Observer(
      builder: (BuildContext context) => StreamBuilder(
          stream: FirebaseFirestore.instance.collection('hortas').where("idUsuario", isEqualTo: usuario?.uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 0, 71, 129)),
                ),
              );
            }
            try {
              Dados.ds = snapshot.data?.docs[0];
            } catch (e) {
              return const Center(
                child: Text(
                  "Nenhuma Horta Castrada",
                  style: TextStyle(fontSize: 20),
                ),
              );
            }
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
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text(
                                      'Cuidado',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 212, 45, 33)),
                                    ),
                                    content: const Text(
                                        'Deseja Realmente Remover a Horta/Estufa \nTodos os alertas registrados para essa horta serão removidos'),
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
                                            // ignore: use_build_context_synchronously
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
