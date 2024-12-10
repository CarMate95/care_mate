import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../widgets/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: SingleChildScrollView(
        // sign up body
        child: SignUpBody(),
      ),
    );
  }
}
