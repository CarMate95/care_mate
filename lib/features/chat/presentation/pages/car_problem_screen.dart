import 'package:car_mate/core/utils/widgets/custom_scaffold_message.dart';
import 'package:car_mate/features/chat/presentation/cubits/car_problem_cubit/car_problem_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/functions/spacing.dart';
import '../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../../../../core/utils/widgets/custom_text_form_field.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/success_ai_dialog.dart';

class CarProblemScreen extends StatefulWidget {
  const CarProblemScreen({super.key});

  @override
  State<CarProblemScreen> createState() => _CarProblemScreenState();
}

class _CarProblemScreenState extends State<CarProblemScreen> {
  final _formKey = GlobalKey<FormState>();
  final problemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarProblemCubit(),
      child: CustomScaffold(
        body: SingleChildScrollView(
          // sign up body
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // custom app bar
                const MainAppBar(isChatbotScreen: true),
                verticalSpace(20),
                CustomTextFormField(
                  labelText: 'Enter Your Car Problem',
                  maxLines: 4,
                  controller: problemController,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocConsumer<CarProblemCubit, CarProblemState>(
          listener: (context, state) {
            if (state is CarProblemSuccess) {
              // show dialog with problem
              showSuccessAiDialog(
                context,
                title: 'Car Problem',
                message: state.problem,
              );
            }
            if (state is CarProblemError) {
              // show error message
              showScaffoldMessage(context, message: state.message);
            }
          },
          builder: (context, state) {
            var carProblemCubit = CarProblemCubit.get(context);
            return IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: CustomElevatedButton(
                  isLoading: state is CarProblemLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await carProblemCubit.getCarProblem(
                        problem: problemController.text,
                      );
                    }
                  },
                  text: 'Get Problem',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
