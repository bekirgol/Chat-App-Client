import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketio_example/Viewmodels/Providers/login_provider.dart';
import 'package:socketio_example/Views/Widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomTextField(
            text: "Email giriniz",
            controller: loginProvider.emailController,
          ),
          CustomTextField(
            text: "Parola giriniz",
            controller: loginProvider.passwordController,
            type: TextInputType.visiblePassword,
          ),
          ElevatedButton(
            child: Text("Login"),
            onPressed: loginProvider.loginWithEmailAndPassword,
          ),
        ],
      ),
    );
  }
}
