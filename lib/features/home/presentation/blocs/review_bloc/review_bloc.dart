import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/review_repository.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewRepository repository;

  ReviewBloc(this.repository) : super(ReviewInitial()) {
    on<LoadReviews>(_onLoadReviews);
    on<SubmitReview>(_onSubmitReview);
  }

  Future<void> _onLoadReviews(
      LoadReviews event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final reviews = await repository.getReviews(event.productId);
      emit(ReviewLoaded(reviews));
    } catch (e) {
      emit(ReviewError('Failed to load reviews: ${e.toString()}'));
    }
  }

  Future<void> _onSubmitReview(
      SubmitReview event, Emitter<ReviewState> emit) async {
    // First emit the submitting state to show loading
    emit(ReviewSubmitting());

    try {
      // Add a small delay to make the loading indicator visible
      await Future.delayed(const Duration(milliseconds: 800));

      // Submit the review
      final success = await repository.submitReview(event.review);

      if (success) {
        // If submission successful, emit submitted state
        emit(ReviewSubmitted());

        // Wait a bit for the success dialog to show, then reload reviews
        await Future.delayed(const Duration(milliseconds: 1500));

        // We'll reload reviews to show the newly added review
        add(LoadReviews(event.review.productId));
      } else {
        // If submission failed for any reason
        emit(ReviewError('Failed to submit review'));
      }
    } catch (e) {
      // If an exception occurs during submission
      emit(ReviewError('Error submitting review: ${e.toString()}'));
    }
  }
}
