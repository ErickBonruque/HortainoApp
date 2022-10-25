import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfo/pages/home.dart';
import 'package:pfo/controller/pagina.controller.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      Provider<ControlarEstado>(
        create: (context) => ControlarEstado(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.comfortaa(),
      ),
      home: Home(),
    ),
  ));
}
