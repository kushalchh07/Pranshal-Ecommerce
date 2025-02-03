import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pranshal_ecommerce/features/home/data/models/home_model.dart';

import '../../../data/repositories/homepage_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    final HomePageRepository homeRepository = HomePageRepository();
    on<HomePageLoadEvent>((event, emit) async {
      log('HomePageBloc: Loading home data');
      emit(HomePageLoading());

      try {
        log('HomePageBloc: Fetching home data...');
        final homeData = await homeRepository.fetchHomeData();
        log('HomePageBloc: Home data fetched: $homeData');
        emit(HomePageLoaded(homeResponse: homeData));
      } catch (e) {
        log('HomePageBloc: Error fetching home data: $e');
        emit(HomePageError(message: e.toString()));
      }
    });
  }
}
