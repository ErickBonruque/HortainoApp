// ignore_for_file: file_names
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cadastro.dart';
import 'home.dart';

class LoginCadastroPage extends StatefulWidget {
  const LoginCadastroPage({Key? key}) : super(key: key);

  @override
  State<LoginCadastroPage> createState() => _LoginCadastroPageState();
}

class _LoginCadastroPageState extends State<LoginCadastroPage> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool mostrarSenha = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bem Vindo de Volta!"),
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
                    "Insira seus dados",
                    style: TextStyle(fontSize: 22),
                  )),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 40),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.blue,
                        size: 20,
                      ),
                      labelText: "Email",
                      hintText: "ex: fulano@gmail.com",
                      labelStyle: TextStyle(fontSize: 20)),
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
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
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
                      icon: const Icon(
                        Icons.lock,
                        color: Colors.blue,
                        size: 20,
                      ),
                      labelText: "Senha",
                      labelStyle: const TextStyle(fontSize: 20)),
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
                          refLogin();
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
              const Text("Ainda não possui uma conta?"),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Cadastro())));
                    },
                    child: const Text("Criar uma Conta")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refLogin() async {
    if (EmailValidator.validate(email.text) == false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email Invalido"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    try {
      final firebaseAuth = FirebaseAuth.instance;
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email.text, password: senha.text);
      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
            (Route<dynamic> route) => false);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Erro")));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Usuario Inexistente")));
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Senha Incorreta")));
      }
    }
  }
}
