
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_car_state.dart';

class MyCarCubit extends Cubit<MyCarState> {
  MyCarCubit() : super(MyCarInitial());
}
