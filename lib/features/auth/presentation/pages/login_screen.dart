import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: SingleChildScrollView(
        // login body
        child: LoginBody(),
      ),
    );
  }
}
