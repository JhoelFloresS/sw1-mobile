import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../widgets/auth_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar Sesión"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthTextField(
              controller: _emailController,
              hintText: "Correo electrónico",
              icon: Icons.email,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              controller: _passwordController,
              hintText: "Contraseña",
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is AuthSuccess) {

                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      LoginEvent(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
                  },
                  child: const Text("Iniciar Sesión"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
