import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ParkingScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obs = true;

  //------------METODO LOGIN CON FIREBASE AUTH-------------
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Si la autenticación fue exitosa, navega a la pantalla principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ParkingScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Ocurrió un error";

      if (e.code == 'user-not-found') {
        message = "No existe un usuario con ese correo";
      } else if (e.code == 'wrong-password') {
        message = "Contraseña incorrecta";
      } else if (e.code == 'invalid-email') {
        message = "Formato de correo no válido";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen del logo
            Image.asset(
              "assets/images/logo.png",
              height: 100,
            ),
            SizedBox(height: 20),

            // Título
            Text(
              "Inicia sesión ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Subtítulo
            Text(
              "Para disfrutar de todos los beneficios",
              style: TextStyle(fontSize: 14, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Campo de texto para correo
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Correo electrónico",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: emailController,
              cursorColor: Colors.lightBlue.shade900,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue.shade900, width: 2),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              ),
            ),
            SizedBox(height: 20),

            // Campo de texto para contraseña
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Contraseña",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: passwordController,
              obscureText: obs,
              cursorColor: Colors.lightBlue.shade900,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue.shade900, width: 2),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                suffixIcon: IconButton(
                  icon: Icon(
                    obs ? Icons.visibility_off : Icons.visibility,
                    color: Colors.lightBlue.shade900,
                  ),
                  onPressed: () {
                    setState(() {
                      obs = !obs;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30),

            // Botón de Iniciar Sesión
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0071CE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "Iniciar sesión",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
