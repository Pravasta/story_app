import 'package:flutter_bloc/flutter_bloc.dart';

class BottomIndexCubit extends Cubit<int> {
  BottomIndexCubit() : super(0);

  void changeBottomIndex(int index) {
    emit(index);
  }
}
