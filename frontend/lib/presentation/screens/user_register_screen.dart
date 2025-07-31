import 'package:flutter/material.dart';
import 'package:garage_app/utils/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Create new account", style: Theme.of(context).textTheme.labelLarge),
                        SizedBox(height: 24),
                        _inputField("Username", usernameController),
                        SizedBox(height: 12),
                        _inputField("Email", emailController),
                        SizedBox(height: 12),
                        _inputField(
                          "Password",
                          passwordController,
                          isObscure: _obscurePassword,
                          toggleVisibility: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        SizedBox(height: 12),
                        _inputField(
                          "Confirm password",
                          confirmPasswordController,
                          isObscure: _obscureConfirmPassword,
                          toggleVisibility: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _registerUser,
                            child: Text("AGREE AND REGISTER"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(
    String hint,
    TextEditingController controller, {
    bool isObscure = false,
    VoidCallback? toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: toggleVisibility != null
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: toggleVisibility,
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "$hint is required";

        if (hint == "Email" && !value.contains('@')) {
          return "Enter a valid email";
        }

        if (hint == "Password" && value.length < 6) {
          return "Password must be at least 6 characters";
        }

        if (hint == "Confirm password" &&
            value != passwordController.text) {
          return "Passwords do not match";
        }

        return null;
      },
    );
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      final result = await AuthService().registerUser(
        usernameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        "USER"
      );
      setState(() => isLoading = false);

      result == "success"
          ? Navigator.pop(context)
          : _showSnackbar(result);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
