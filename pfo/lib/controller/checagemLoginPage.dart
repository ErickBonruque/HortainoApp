// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/loginCadastroPage.dart';

class ChecagemLoginPage extends StatefulWidget {
  const ChecagemLoginPage({Key? key}) : super(key: key);

  @override
  State<ChecagemLoginPage> createState() => _ChecagemLoginPageState();
}

class _ChecagemLoginPageState extends State<ChecagemLoginPage> {
  @override
    void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const LoginCadastroPage()),(Route<dynamic> route) => false);
      }
      else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const Home()),(Route<dynamic> route) => false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}