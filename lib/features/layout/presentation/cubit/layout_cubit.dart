import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit({required this.screens}) : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of<LayoutCubit>(context);

  final List<Widget> screens;
  int currentIndex = 0;

  void changeScreen(int index) {
    currentIndex = index;
    emit(LayoutChanged());
  }
}
