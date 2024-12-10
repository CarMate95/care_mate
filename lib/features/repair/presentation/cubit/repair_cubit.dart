
import 'package:flutter_bloc/flutter_bloc.dart';

part 'repair_state.dart';

class RepairCubit extends Cubit<RepairState> {
  RepairCubit() : super(RepairInitial());
}
