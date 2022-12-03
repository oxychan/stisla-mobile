import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stisla/service/auth_service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  bool isLoading = false;

  String? nameError;
  String? emailError;
  String? passwordError;
  String? passwordConfirmationError;

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
                  center: const Text('Registering'),
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
                            "Register untuk menggunakan aplikasi",
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
                          vertical: 24.0,
                          horizontal: 24.0,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: "Name",
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.grey[600],
                                      ),
                                      errorText: nameError,
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
                                        nameError = null;
                                        emailError = null;
                                        passwordError = null;
                                        passwordConfirmationError = null;
                                      });
                                    },
                                  ),
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
                                        nameError = null;
                                        emailError = null;
                                        passwordError = null;
                                        passwordConfirmationError = null;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
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
                                        nameError = null;
                                        emailError = null;
                                        passwordError = null;
                                        passwordConfirmationError = null;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    controller: passwordConfirmationController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                      hintText: "Password Confirmation",
                                      prefixIcon: Icon(
                                        Icons.key,
                                        color: Colors.grey[600],
                                      ),
                                      errorText: passwordConfirmationError,
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
                                        nameError = null;
                                        emailError = null;
                                        passwordError = null;
                                        passwordConfirmationError = null;
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
                                      AuthService.requestRegister(
                                              nameController.text,
                                              emailController.text,
                                              passwordController.text,
                                              passwordConfirmationController
                                                  .text)
                                          .then((response) {
                                        if (response.statusCode == 200) {
                                          Navigator.pushNamed(context, '/');
                                        } else if (response.statusCode == 422) {
                                          var jsonObj =
                                              json.decode(response.body);
                                          var errors = jsonObj['errors'];
                                          setState(() {
                                            if (errors.length > 2) {
                                              nameError = errors['name'][0];
                                              emailError = errors['email'][0];
                                              passwordError =
                                                  errors['password'][0];
                                            } else {
                                              if (errors.containsKey('name')) {
                                                nameError = errors['name'][0];
                                              }

                                              if (errors.containsKey('email')) {
                                                emailError = errors['email'][0];
                                              }

                                              if (errors
                                                  .containsKey('password')) {
                                                passwordError =
                                                    errors['password'][0];
                                              }

                                              if (errors.containsKey(
                                                      'password') &&
                                                  errors['password'] ==
                                                      'The password confirmation does not match.') {
                                                passwordConfirmationError =
                                                    errors['password'][0];
                                              }
                                            }
                                          });
                                        }
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Register",
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
                                          "have account?",
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/login');
                                          },
                                          child: const Text(
                                            "Login",
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
