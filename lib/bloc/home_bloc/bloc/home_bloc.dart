import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urlshortener/bloc/home_bloc/bloc/home_event.dart';
import 'package:urlshortener/bloc/home_bloc/bloc/home_state.dart';
import 'package:urlshortener/modal/short_api_modal.dart';
import 'package:urlshortener/network/api_endpoints.dart';
import 'package:urlshortener/network/api_service.dart';

final APIService _apiService = APIService();

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeCreateShortUrlEvent>(
        (event, emit) => _onCreate(event, emit, state as HomeInitialState));
  }

  void _onCreate(HomeCreateShortUrlEvent event, Emitter<HomeState> emit,
      HomeInitialState currState) async {
    dynamic body = {'destination': event.longUrl};

    emit(currState.copyWith(creating: true));
    await _apiService.request(ApiEndpoint.kShortAPIUrl, body).then((response) {
      print("response========>>>>>>");
      print(response.data);

      if (response.data != null) {
        ShortUrlResponseModal responseModal =
            ShortUrlResponseModal.fromJson(response.data);
        print(responseModal);
        emit(HomeSuccesState());
        emit(
          currState.copyWith(
            creating: false,
            responseModal: responseModal,
          ),
        );
      }

      print(response);
    }).catchError((e) {
      print('Error ========>>>');
      print(e);
      emit(HomeErrortate(message: e.toString()));
      emit(currState.copyWith(creating: true));
    });
  }
}
