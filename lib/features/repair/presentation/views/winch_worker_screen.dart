import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_winch_and_worker_cubit.dart';
import 'package:car_mate/features/repair/presentation/views/winch_view.dart';
import 'package:car_mate/features/repair/presentation/views/worker_view.dart';
import 'package:easy_localization/easy_localization.dart';

class WorkerAndWinchScreen extends StatefulWidget {
  const WorkerAndWinchScreen({super.key});

  @override
  State<WorkerAndWinchScreen> createState() => _WorkerAndWinchScreenState();
}

class _WorkerAndWinchScreenState extends State<WorkerAndWinchScreen> {
  bool isClicked = true;
  bool isWinchSelected = true;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var cubit = context.read<GetWinchAndWorkerCubit>();

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(20),
              CustomAppBar(
                enbleBackIcon: true,
                isSettingsIcon: true,
                title: Container(
                  width: mediaQuery.width * 0.6,
                  height: mediaQuery.height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10000),
                    color: context.tertiaryColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isClicked = true;
                              isWinchSelected = true;
                            });
                            cubit.fetchWinch();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isClicked
                                ? ColorManager.transparent
                                : context.tertiaryColor,
                            overlayColor: ColorManager.transparent,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: isClicked
                                      ? context.secondaryColor
                                      : Colors.transparent),
                              borderRadius: BorderRadius.circular(10000),
                            ),
                          ),
                          child: Text(
                            TextManager.winch.tr(),
                            style: getMediumStyle(
                              color: isClicked
                                  ? context.secondaryColor
                                  : ColorManager.grey,
                              fontSize: isClicked ? 20 : 16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isClicked = false;
                              isWinchSelected = false;
                            });
                            cubit.fetchWorker();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isClicked
                                ? context.tertiaryColor
                                : ColorManager.transparent,
                            elevation: 0.0,
                            overlayColor: ColorManager.transparent,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: isClicked
                                      ? ColorManager.transparent
                                      : context.secondaryColor),
                              borderRadius: BorderRadius.circular(10000),
                            ),
                          ),
                          child: Text(
                            TextManager.worker.tr(),
                            style: getMediumStyle(
                              color: isClicked
                                  ? ColorManager.grey
                                  : context.secondaryColor,
                              fontSize: isClicked ? 16 : 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(10),
              isWinchSelected ? const WinchView() : const WorkerView(),
            ],
          ),
        ),
      ),
    );
  }
}
