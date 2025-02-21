import 'package:car_mate/core/utils/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<AuthCubit>(),
      child: const CustomScaffold(
        body: SingleChildScrollView(
          // login body
          child: LoginBody(),
        ),
      ),
    );
  }
}
