import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/home_model.dart';
import '../../../data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitialState()) {
    final categoryRepository = CategoryRepository();
    on<CategorySearchEvent>((event, emit)async {
      emit(CategoryLoadingState());
      try{
final categories = await categoryRepository.searchCategories(event.query);
        emit(CategoryLoadedState(categories: categories));
      }catch(e){
        emit(CategoryErrorState(error: e.toString()));
      }
    });
  }
}
