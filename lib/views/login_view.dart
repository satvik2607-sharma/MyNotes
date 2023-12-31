import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/auth_exceptions.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_event.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool passwordVisible = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    passwordVisible = true;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
                context, 'Cannot find a user with entered credentials');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credentials');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/icon/icon.png",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                    'Please log in to your account in order to interact with and create notes!'),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration:
                      const InputDecoration(hintText: 'Enter your email here'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: _password,
                  obscureText: passwordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: 'Enter your password here',
                      suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          })),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      
                      context.read<AuthBloc>().add(AuthEventLogIn(
                            email,
                            password,
                          ));
                    },
                    child: const Text(
                      'Login',
                    )),
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventForgotPassword(),
                          );
                    },
                    child: const Text('Forgot Password?')),
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventShouldRegister(),
                          );
                    },
                    child: const Text('Not registered yet? Register here!')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
