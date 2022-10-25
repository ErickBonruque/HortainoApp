// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagina.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControlarEstado on _ControlarEstado, Store {
  late final _$alertasAtom =
      Atom(name: '_ControlarEstado.alertas', context: context);

  @override
  List<Alerta> get alertas {
    _$alertasAtom.reportRead();
    return super.alertas;
  }

  @override
  set alertas(List<Alerta> value) {
    _$alertasAtom.reportWrite(value, super.alertas, () {
      super.alertas = value;
    });
  }

  late final _$hortasAtom =
      Atom(name: '_ControlarEstado.hortas', context: context);

  @override
  List<Horta> get hortas {
    _$hortasAtom.reportRead();
    return super.hortas;
  }

  @override
  set hortas(List<Horta> value) {
    _$hortasAtom.reportWrite(value, super.hortas, () {
      super.hortas = value;
    });
  }

  late final _$_ControlarEstadoActionController =
      ActionController(name: '_ControlarEstado', context: context);

  @override
  dynamic addAlerta(Alerta alerta) {
    final _$actionInfo = _$_ControlarEstadoActionController.startAction(
        name: '_ControlarEstado.addAlerta');
    try {
      return super.addAlerta(alerta);
    } finally {
      _$_ControlarEstadoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removerAlerta(DocumentSnapshot e) {
    final _$actionInfo = _$_ControlarEstadoActionController.startAction(
        name: '_ControlarEstado.removerAlerta');
    try {
      return super.removerAlerta(e);
    } finally {
      _$_ControlarEstadoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addHorta(Horta horta) {
    final _$actionInfo = _$_ControlarEstadoActionController.startAction(
        name: '_ControlarEstado.addHorta');
    try {
      return super.addHorta(horta);
    } finally {
      _$_ControlarEstadoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removerHorta(DocumentSnapshot e) {
    final _$actionInfo = _$_ControlarEstadoActionController.startAction(
        name: '_ControlarEstado.removerHorta');
    try {
      return super.removerHorta(e);
    } finally {
      _$_ControlarEstadoActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
alertas: ${alertas},
hortas: ${hortas}
    ''';
  }
}
