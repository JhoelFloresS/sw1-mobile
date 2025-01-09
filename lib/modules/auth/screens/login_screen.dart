import 'package:agenda_mobile/modules/auth/blocs/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is Authenticated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bienvenido ${state.session.user.name}!')),
                      );
                      Navigator.pushReplacementNamed(context, '/');
                      // Navegar a la pantalla principal
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message), backgroundColor: Colors.red,),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Usuario',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final username = usernameController.text;
                              final password = passwordController.text;
                              context.read<AuthBloc>().add(LoginEvent(username, password));
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              backgroundColor: Colors.blueAccent
                            ),
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(fontSize: 16.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
