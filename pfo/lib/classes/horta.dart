class Horta {
  String? _nome;
  String? _desc;
  String? _hortalica;
  String? _id;

  Horta(this._nome, this._desc, this._hortalica, this._id);
  get id => _id;

  set id(value) => _id = value;

  get nome => _nome;

  set nome(value) => _nome = value;

  get desc => _desc;

  set desc(value) => _desc = value;

  get hortalica => _hortalica;

  set hortalica(value) => _hortalica = value;
}
