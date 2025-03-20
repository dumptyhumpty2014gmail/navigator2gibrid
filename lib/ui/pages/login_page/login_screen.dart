import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main_vm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainVM = context.read<MainVM>();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            mainVM.changeLoginState(true);
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
