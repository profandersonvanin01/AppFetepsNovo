// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:feteps/sobre_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feteps/home_page.dart';
import 'package:feteps/telainicial_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//AJUSTES NA RESPONSIVIDADE
class LoginFetepsPage extends StatefulWidget {
  const LoginFetepsPage({super.key});

  @override
  State<LoginFetepsPage> createState() => _LoginFetepsPageState();
}

class _LoginFetepsPageState extends State<LoginFetepsPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 400,
          height: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TelaInicialPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    size: MediaQuery.of(context).size.width * 0.075,
                    Icons.arrow_back_sharp,
                    color: const Color(0xFF0E414F),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                child: Image.asset(
                  'lib/assets/logo.png',
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFB6382B),
                            width: 3.5,
                          )),
                      child: ClipOval(
                        child: Image.asset(
                          'lib/assets/fundo.png',
                          width: MediaQuery.of(context).size.width * 0.65,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: GoogleFonts.roboto(
                        fontSize: MediaQuery.of(context).size.width * 0.069,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              //Text formfield EMAIL
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.82,
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'E-mail',
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return 'Por favor digite seu e-mail';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(_emailController.text)) {
                                  return 'Por favor, digite um e-mail correto';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.038,
                          ),
                          //Text formfiel SENHA
                          Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                labelStyle: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              validator: (senha) {
                                if (senha == null || senha.isEmpty) {
                                  return 'Por favor, digite a sua senha';
                                } else if (senha.length < 3) {
                                  return 'Por favor, digite uma senha maior de 3 caracteres';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Color(0xFFB6382B),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.012,
                                      right: MediaQuery.of(context).size.width *
                                          0.012),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (_formKey.currentState!.validate()) {
                                        bool deuCerto = await login();
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                        if (deuCerto) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SobrePage(),
                                            ),
                                          );
                                        } else {
                                          _passwordController.clear();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(100, 39),
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0),
                                      ),
                                    ),
                                    child: Text(
                                      "Confirmar",
                                      style: GoogleFonts.oswald(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.048,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Esqueci minha senha",
                                    style: GoogleFonts.oswald(
                                      color: Color(0xFF0E414F),
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.042,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final snackBar = const SnackBar(
    content: Text(
      'e-mail ou senha são inválidos',
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final url = Uri.parse(
        'https://profandersonvanin.com.br/appfeteps/pages/Users/loginUser.php?userEmail=${_emailController.text}&userPassword=${_passwordController.text}');

    final corpo = jsonEncode(<String, String>{});
    final resposta = await http.post(
      url,
      body: corpo,
    );
    //print('Resposta do Login: ' + resposta);
    print('Token Login: ' + jsonDecode(resposta.body)['token']);
    print('Nome Usuario: ' + jsonDecode(resposta.body)['userName']);
    String nomeUsuario = jsonDecode(resposta.body)['userName'];
    String idUsuario = (jsonDecode(resposta.body)['userId']).toString();
    print('Id Usuario: ' + (jsonDecode(resposta.body)['userId']).toString());

    if (resposta.statusCode == 200) {
      final url2 = Uri.parse(
          'https://profandersonvanin.com.br/appfeteps/pages/Users/authUser.php');

      final response = await http.get(url2);
      String meuToken = json.decode(response.body)['token'];

      print('Token depois de Logado: ' + json.decode(response.body)['token']);

      await sharedPreferences.setString('token', meuToken);
      await sharedPreferences.setString('nomeUsuario', nomeUsuario);
      await sharedPreferences.setString('idUsuario', idUsuario);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> verificarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token != null) {
      final url = Uri.parse(
          'https://profandersonvanin.com.br/appfeteps/pages/Auth/verifyToken.php');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
