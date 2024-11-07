part of 'create_product_bloc.dart';

sealed class CreateProductEvent extends Equatable {
  const CreateProductEvent();

  @override
  List<Object> get props => [];
}

class UpdateTitleEvent extends CreateProductEvent {
  final String newTitle;

  const UpdateTitleEvent({required this.newTitle});
}

class UpdateAuthorEvent extends CreateProductEvent {
  final String newAuthor;

  const UpdateAuthorEvent({required this.newAuthor});
}

class UpdatePublisherEvent extends CreateProductEvent {
  final String newPublisher;

  const UpdatePublisherEvent({required this.newPublisher});
}

class UpdatePublishingYearEvent extends CreateProductEvent {
  final DateTime newYear;

  const UpdatePublishingYearEvent({required this.newYear});
}

class UpdateBookTypeEvent extends CreateProductEvent {
  final BookType newType;

  const UpdateBookTypeEvent({required this.newType});
}

class AddImageEvent extends CreateProductEvent {
  final List<File> newImages;

  const AddImageEvent({required this.newImages});
}

class RemoveImageEvent extends CreateProductEvent {
  final File removedImage;

  const RemoveImageEvent({required this.removedImage});
}

class UpdateDescriptionEvent extends CreateProductEvent {
  final String newDescription;

  const UpdateDescriptionEvent({required this.newDescription});
}

class UpdatePriceEvent extends CreateProductEvent {
  final String newPrice;

  const UpdatePriceEvent({required this.newPrice});
}

class UpdateDiscountEvent extends CreateProductEvent {
  final String newDiscount;

  const UpdateDiscountEvent({required this.newDiscount});
}

class ConfirmCreateEvent extends CreateProductEvent {}
