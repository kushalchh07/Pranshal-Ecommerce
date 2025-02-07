import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/home_model.dart';
import '../../../data/repositories/brand_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc() : super(BrandInitialState()) {
    final brandRepository = BrandRepository();
    on<BrandSearchEvent>((event, emit) async {
      // TODO: implement event handler
      emit(BrandLoadingState());
      try {
        final brands = await brandRepository.searchBrands(event.query);
        emit(BrandLoadedState(brands: brands));
      } catch (e) {
        emit(BrandErrorState(error: e.toString()));
      }
    });
  }
}
