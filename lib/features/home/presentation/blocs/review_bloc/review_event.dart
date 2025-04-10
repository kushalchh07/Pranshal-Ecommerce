import '../../../data/models/review_model.dart';


abstract class ReviewEvent {}

class LoadReviews extends ReviewEvent {
  final int productId;

  LoadReviews(this.productId);
}

class SubmitReview extends ReviewEvent {
  final Review review;

  SubmitReview(this.review);
}
