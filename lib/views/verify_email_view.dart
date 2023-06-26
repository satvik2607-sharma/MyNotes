import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/routes.dart';
import 'package:flutter_application_1/services/auth/auth_srvice.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email'),),
      body: Column(children: [
        const Text("We've have sent you an email verification. Please open it to verify your account"),
        const Text("If you haven't received the email, click on the button below"),
          
          TextButton(onPressed: ()async{
            await AuthService.firebase().SendEmailVerication();
          }, child: const Text('Send email verification')),

          TextButton(onPressed: ()async {
            await AuthService.firebase().logOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }, child: const Text('Restart')),
        ]),
    );
  }
}