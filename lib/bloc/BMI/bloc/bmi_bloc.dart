import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc() : super(BmiInitial()) {
    on<BmiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
