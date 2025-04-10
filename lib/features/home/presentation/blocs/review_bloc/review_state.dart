import '../../../data/models/review_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  ReviewLoaded(this.reviews);
}

class ReviewSubmitting extends ReviewState {}

class ReviewSubmitted extends ReviewState {}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);
}
