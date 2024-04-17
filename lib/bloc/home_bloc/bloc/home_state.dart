import 'package:equatable/equatable.dart';
import 'package:urlshortener/modal/short_api_modal.dart';

abstract class HomeState extends Equatable {}

class HomeLoadState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {
  final bool creating;
  final ShortUrlResponseModal? responseModal;

  HomeInitialState({
    this.creating = false,
    this.responseModal,
  });
  @override
  List<Object?> get props => [responseModal, creating];

  HomeInitialState copyWith(
          {bool? creating, ShortUrlResponseModal? responseModal}) =>
      HomeInitialState(
        creating: creating ?? this.creating,
        responseModal: responseModal ?? this.responseModal,
      );
}

class HomeSuccesState extends HomeState {
  final String? message;

  HomeSuccesState({this.message});
  @override
  List<Object?> get props => [];
}

class HomeErrortate extends HomeState {
  final String? message;

  HomeErrortate({this.message});
  @override
  List<Object?> get props => [];
}
