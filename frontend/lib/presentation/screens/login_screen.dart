import 'package:flutter/material.dart';
import 'package:garage_app/presentation/screens/user_home_screen.dart';
import 'package:garage_app/presentation/screens/user_register_screen.dart';
import 'package:garage_app/utils/auth_service.dart';


class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           Positioned.fill(
            child: Image.asset(
              'assets/images/bgimage.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Back", style: Theme.of(context).textTheme.labelLarge),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(hintText: "Email"),
                        validator: (val) => val!.isEmpty ? "Enter email" : null,
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(hintText: "Password", suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),),
                        obscureText: _obscurePassword,
                        validator: (val) => val!.isEmpty ? "Enter password" : null,
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await AuthService().loginUser(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              result == "success"
                                  ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged in")))
                                  : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                             if( result == "success"){
                               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,);
                             }

                            }
                          },
                          child: Text("LOGIN"),
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => RegisterScreen()),
                            );
                          },
                          child: Text("Don't have an account? Register"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
