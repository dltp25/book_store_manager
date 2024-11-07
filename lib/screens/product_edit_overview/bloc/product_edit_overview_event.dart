part of 'product_edit_overview_bloc.dart';

sealed class ProductEditOverviewEvent extends Equatable {
  const ProductEditOverviewEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends ProductEditOverviewEvent {
  final ProductModel product;

  const InitialEvent({required this.product});
}

class UpdateTitleEvent extends ProductEditOverviewEvent {
  final String newTitle;

  const UpdateTitleEvent({required this.newTitle});
}

class UpdateAuthorEvent extends ProductEditOverviewEvent {
  final String newAuthor;

  const UpdateAuthorEvent({required this.newAuthor});
}

class UpdatePublisherEvent extends ProductEditOverviewEvent {
  final String newPublisher;

  const UpdatePublisherEvent({required this.newPublisher});
}

class UpdatePublishingYearEvent extends ProductEditOverviewEvent {
  final DateTime newYear;

  const UpdatePublishingYearEvent({required this.newYear});
}

class UpdateBookTypeEvent extends ProductEditOverviewEvent {
  final BookType newType;

  const UpdateBookTypeEvent({required this.newType});
}

class UpdateDescriptionEvent extends ProductEditOverviewEvent {
  final String newDescription;

  const UpdateDescriptionEvent({required this.newDescription});
}

class ConfirmUpdateEvent extends ProductEditOverviewEvent {}
