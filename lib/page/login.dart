import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stisla/service/auth_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =
      TextEditingController(text: 'superadmin@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'password');

  bool isLoading = false;

  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff6777ef),
        ),
        child: isLoading
            ? Center(
                child: CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 10.0,
                  percent: 1.0,
                  animation: true,
                  center: const Text('Loading'),
                  progressColor: const Color(0xff6777ef),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 36.0,
                        horizontal: 24.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "STISLA",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Login untuk menggunakan aplikasi",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 24.0,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image(
                                      image: AssetImage('assets/stisla.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: "E-mail",
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.grey[600],
                                      ),
                                      errorText: emailError,
                                      errorStyle: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1.0),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        emailError = null;
                                        passwordError = null;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: "Password",
                                      prefixIcon: Icon(
                                        Icons.key,
                                        color: Colors.grey[600],
                                      ),
                                      errorText: passwordError,
                                      errorStyle: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1.0),
                                      ),
                                    ),
                                    obscureText: true,
                                    onTap: () {
                                      setState(() {
                                        passwordError = null;
                                        emailError = null;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.white,
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        const Color(0xff6777ef),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          side: const BorderSide(
                                            color: Color(0xff6777ef),
                                          ),
                                        ),
                                      ),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                        const Size.fromHeight(50),
                                      ),
                                    ),
                                    onPressed: () {
                                      AuthService.requestLogin(
                                              emailController.text,
                                              passwordController.text)
                                          .then(
                                        (response) {
                                          if (response.statusCode == 200) {
                                            Navigator.pushNamed(context, '/');
                                          } else if (response.statusCode ==
                                              422) {
                                            var jsonObj =
                                                json.decode(response.body);
                                            var errors = jsonObj['errors'];
                                            setState(() {
                                              if (errors.length > 1) {
                                                emailError = errors['email'][0];
                                                passwordError =
                                                    errors['password'][0];
                                              } else {
                                                if (errors
                                                    .containsKey('email')) {
                                                  emailError =
                                                      errors['email'][0];
                                                } else {
                                                  passwordError =
                                                      errors['password'][0];
                                                }
                                              }
                                            });
                                          }
                                        },
                                      );
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "don't have account?",
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/register');
                                          },
                                          child: const Text(
                                            "Register",
                                            style: TextStyle(
                                              color: Color(0xff6777ef),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
