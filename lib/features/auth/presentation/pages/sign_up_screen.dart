import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AuthCubit.get(context),
      child: const CustomScaffold(
        body: SingleChildScrollView(
          // sign up body
          child: SignUpBody(),
        ),
      ),
    );
  }
}
