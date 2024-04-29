part of 'bmi_bloc.dart';

sealed class BmiState extends Equatable {
  const BmiState();
  
  @override
  List<Object> get props => [];
}

final class BmiInitial extends BmiState {}
