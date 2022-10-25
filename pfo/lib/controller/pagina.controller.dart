import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import '../classes/alerta.dart';
import '../classes/horta.dart';
part 'pagina.controller.g.dart';

// ignore: library_private_types_in_public_api
class ControlarEstado = _ControlarEstado with _$ControlarEstado;

abstract class _ControlarEstado with Store {
  @observable
  List<Alerta> alertas = ObservableList<Alerta>.of([]);
  @observable
  List<Horta> hortas = ObservableList<Horta>.of([]);
  @action
  addAlerta(Alerta alerta) {
    final docAlerta = FirebaseFirestore.instance.collection("alertas").doc();
    docAlerta.set({
      "nome": alerta.nome,
      "descricao": alerta.desc,
      "temperatura": alerta.temperatura,
      "umidade": alerta.umidade,
      "id": docAlerta.id,
      "idHorta": alerta.idHorta,
    });
    alertas.add(alerta);
    if (kDebugMode) {
      print(alerta);
    }
  }
  @action
  removerAlerta(DocumentSnapshot e) {
    FirebaseFirestore.instance.collection("alertas").doc(e.id).delete();
  }

  @action
  updateHorta(Horta horta, DocumentSnapshot e) {
    final docHorta = FirebaseFirestore.instance.collection("hortas").doc(e.id);
    docHorta.update({
      "nome": horta.nome,
      "descricao": horta.desc,
      "hortalica": horta.hortalica,
      "id": e.id,
    });
  }

  @action
  addHorta(Horta horta) async {
    final docHorta = FirebaseFirestore.instance.collection("hortas").doc();
    docHorta.set({
      "nome": horta.nome,
      "descricao": horta.desc,
      "hortalica": horta.hortalica,
      "id": docHorta.id,
    });
  }

  @action
  removerHorta(DocumentSnapshot e) async {
    var collection = FirebaseFirestore.instance.collection("alertas");
    var snapshots = await collection.where("idHorta", isEqualTo: e["id"].toString()).get();
    for (var doc in snapshots.docs) {
      if((doc.get('idHorta').toString()) == (e["id"].toString())){
        await doc.reference.delete();
      }

    }
    FirebaseFirestore.instance.collection("hortas").doc(e.id).delete();
  }
}
