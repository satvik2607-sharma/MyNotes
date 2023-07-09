import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth/auth_srvice.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_application_1/services/auth/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const Text(
              "Dear user, thank you for registering. We've have sent you an email verification. Please open it to verify your account"),
          const Text(
              "If you haven't received the email, click on the button below"),
          TextButton(
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: const Text('Resend email verification')),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                context.read<AuthBloc>().add(AuthEventLogOut());
              },
              child: const Text('Back')),
        ]),
      ),
    );
  }
}
