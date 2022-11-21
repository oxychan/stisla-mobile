import 'package:flutter/material.dart';
import 'package:stisla/service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController =
      TextEditingController(text: 'Taufik');
  final TextEditingController emailController =
      TextEditingController(text: '...@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'password');
  final TextEditingController passwordConfirmationController =
      TextEditingController(text: 'password');

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
        child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "E-mail",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "Password",
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Colors.grey[600],
                                ),
                              ),
                              obscureText: true,
                            ),
                            TextFormField(
                              controller: passwordConfirmationController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: "Password Confirmation",
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Colors.grey[600],
                                ),
                              ),
                              obscureText: true,
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
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: const BorderSide(
                                      color: Color(0xff6777ef),
                                    ),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  const Size.fromHeight(50),
                                ),
                              ),
                              onPressed: () {
                                AuthService.requestRegister(
                                        nameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        passwordConfirmationController.text)
                                    .then((response) {
                                  if (response.statusCode == 200) {
                                    Navigator.pushNamed(context, '/');
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "have account?",
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/login');
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
