import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? emailError, passwordError, confirmPasswordError;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void registerUser() async {
    setState(() {
      emailError = passwordError = confirmPasswordError = null;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty) {
      setState(() => emailError = "Required to fill");
      return;
    } else if (!email.endsWith("@gmail.com")) {
      setState(() => emailError = "Email must end with @gmail.com");
      return;
    }

    if (password.isEmpty) {
      setState(() => passwordError = "Required to fill");
      return;
    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(password)) {
      setState(() => passwordError = "Password must be 8 characters with letters & numbers");
      return;
    }

    if (confirmPassword.isEmpty) {
      setState(() => confirmPasswordError = "Required to fill");
      return;
    } else if (confirmPassword != password) {
      setState(() => confirmPasswordError = "Passwords do not match");
      return;
    }

    try {
      bool emailExists = (await FirebaseAuth.instance.fetchSignInMethodsForEmail(email)).isNotEmpty;
      if (emailExists) {
        setState(() => emailError = "Email is already registered. Please login.");
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registered Successfully! Now you can login."),
          duration: Duration(seconds: 3),
        ),
      );

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() => emailError = "Email is already registered. Please login.");
      } else if (e.code == 'invalid-email') {
        setState(() => emailError = "Invalid email format.");
      } else if (e.code == 'weak-password') {
        setState(() => passwordError = "Password is too weak.");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.message}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              
              buildLabel("Email"),
              buildInputField(emailController, false, emailError, Icons.email),

              buildLabel("Password"),
              buildInputField(passwordController, true, passwordError, Icons.lock),

              buildLabel("Confirm Password"),
              buildInputField(confirmPasswordController, true, confirmPasswordError, Icons.lock_outline),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: registerUser,
                  style: buttonStyle(),
                  child: const Text("Register"),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text("Back to Login", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, bool isPassword, String? error, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: isPassword && (controller == passwordController ? !isPasswordVisible : !isConfirmPasswordVisible),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    (controller == passwordController ? isPasswordVisible : isConfirmPasswordVisible)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      if (controller == passwordController) {
                        isPasswordVisible = !isPasswordVisible;
                      } else {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      }
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          errorText: error,
        ),
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
  }
}
