import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  TextEditingController comfirmarSenha = TextEditingController();
  bool mostrarSenha = true;
  bool mostrarSenha2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        centerTitle: true,
        backgroundColor: const Color(0xFF1DBAF3),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                  margin: const EdgeInsets.all(20),
                  child: const Text(
                    "Insira Seus dados",
                    style: TextStyle(fontSize: 18),
                  )),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 40),
                child: TextFormField(
                  controller: nome,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle, color: Colors.blue, size: 20,),
                      labelText: "Nome",
                      hintText: "Fulano da Silva",
                      labelStyle: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 18),
                child: TextFormField(
                  validator: validarEmail,
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email, color: Colors.blue, size: 20,),
                      labelText: "Email",
                      hintText: "ex: fulano@gmail.com",
                      labelStyle: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 40),
                child: TextFormField(
                  obscureText: mostrarSenha,
                  controller: senha,
                  keyboardType: TextInputType.text,
                  decoration:  InputDecoration(
                      labelText: "Senha", 
                      labelStyle: const TextStyle(fontSize: 18),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          mostrarSenha == false
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onTap: () {
                          setState(() {
                            mostrarSenha = !mostrarSenha;
                          });
                        },
                      ),
                      icon: const Icon(Icons.lock, color: Colors.blue, size: 20,),),
                      
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 40),
                child: TextFormField(
                  obscureText: mostrarSenha2,
                  controller: comfirmarSenha,
                  keyboardType: TextInputType.text,
                  decoration:  InputDecoration(
                      labelText: "Confimar Senha",
                      labelStyle: const TextStyle(fontSize: 18),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          mostrarSenha2 == false
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onTap: () {
                          setState(() {
                            mostrarSenha2 = !mostrarSenha2;
                          });
                        },
                      ),
                      icon: const Icon(Icons.lock, color: Colors.blue, size: 20,),
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                child: ClipRRect(
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
                          refCadastro();
                        },
                        child: const Text('Cadastrar-se'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void refCadastro() {
    if (senha.text != comfirmarSenha.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Senhas precisam ser iguais!"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    final firebaseAuth = FirebaseAuth.instance;
    firebaseAuth
        .createUserWithEmailAndPassword(email: email.text, password: senha.text)
        .then((UserCredential userCredential) {
      var user = userCredential.user!;
      user.updateDisplayName(nome.text);
      // ignore: avoid_print
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bem vindo ao Hortaino!"),
        backgroundColor: Colors.blue,
      ));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Home()),
          (Route<dynamic> route) => false);
      // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((FirebaseAuthException firebaseAuthException) {
      // ignore: unrelated_type_equality_checks
      if (firebaseAuthException == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email já cadastrado!"),
          backgroundColor: Colors.blue,
        ));
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Erro ao cadastrar o usuario!"),
          backgroundColor: Colors.blue,
        ));
        return;
      }
    });
  }

  String? validarEmail(String? value) {
    if (value!.isEmpty) {
      return "Informe um email";
    }
    if (EmailValidator.validate(value) == false) {
      return "Email inválido";
    } else {
      return null;
    }
  }
}
