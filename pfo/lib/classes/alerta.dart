class Alerta {
  String? _nome;
  String? _desc;
  String? _umidade;
  String? _temperatura;
  String? _nomeHorta;
  String? _idHorta;
  // ignore: unnecessary_getters_setters
  String? get nome => _nome;

 set nome(String? value) => _nome = value;

  get desc => _desc;

 set desc( value) => _desc = value;

  get umidade => _umidade;

 set umidade( value) => _umidade = value;

  get temperatura => _temperatura;

 set temperatura( value) => _temperatura = value;

  get nomeHorta => _nomeHorta;

 set nomeHorta( value) => _nomeHorta = value;

  get idHorta => _idHorta;

 set idHorta( value) => _idHorta = value;


  Alerta(this._nome, this._desc, this._umidade, this._temperatura,
      this._nomeHorta, this._idHorta);
}
