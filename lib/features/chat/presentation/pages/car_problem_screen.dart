import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold_message.dart';
import 'package:car_mate/features/chat/presentation/cubits/ai_model_cubit/ai_model_cubit.dart';
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
      create: (context) => AiModelCubit(),
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
                  labelText: TextManager.enterYourCarProblem,
                  maxLines: 4,
                  controller: problemController,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocConsumer<AiModelCubit, AiModelState>(
          listener: (context, state) {
            if (state is AiModelSuccess) {
              // show dialog with problem
              showSuccessAiDialog(
                context,
                title: TextManager.expectedCarProblem,
                message: state.message,
              );
            }
            if (state is AiModelError) {
              // show error message
              showScaffoldMessage(context, message: state.message);
            }
          },
          builder: (context, state) {
            var aiModelCubit = AiModelCubit.get(context);
            return IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: CustomElevatedButton(
                  isLoading: state is AiModelLoading,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await aiModelCubit.getCarProblem(
                        problem: problemController.text,
                      );
                    }
                  },
                  text: TextManager.getProblem,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
