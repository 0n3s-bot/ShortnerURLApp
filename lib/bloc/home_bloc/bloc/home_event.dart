import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class HomeCreateShortUrlEvent extends HomeEvent {
  final String longUrl;

  HomeCreateShortUrlEvent({required this.longUrl});
  @override
  List<Object?> get props => [];
}
