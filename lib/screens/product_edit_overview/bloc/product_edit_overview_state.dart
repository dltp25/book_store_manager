part of 'product_edit_overview_bloc.dart';

class ProductEditOverviewState extends Equatable {
  final bool isLoading;
  final String productId;
  final String productTitle;
  final String author;
  final String publisher;
  final String publishingYear;
  final BookType type;
  final String description;

  final String errTitle;
  final String errAuthor;
  final String errPublisher;
  final String errDescription;

  const ProductEditOverviewState({
    this.isLoading = true,
    this.productId = '',
    this.productTitle = '',
    this.author = '',
    this.publisher = '',
    this.publishingYear = '',
    this.type = BookType.textBook,
    this.description = '',
    this.errAuthor = '',
    this.errTitle = '',
    this.errPublisher = '',
    this.errDescription = '',
  });

  @override
  List<Object?> get props => [
        isLoading,
        productId,
        productTitle,
        author,
        publisher,
        publishingYear,
        type,
        description,
        errTitle,
        errAuthor,
        errPublisher,
        errDescription
      ];

  ProductEditOverviewState copyWith({
    bool? isLoading,
    String? productId,
    String? productTitle,
    String? author,
    String? publisher,
    String? publishingYear,
    BookType? type,
    String? description,
    String? errTitle,
    String? errAuthor,
    String? errPublisher,
    String? errDescription,
  }) {
    return ProductEditOverviewState(
      isLoading: isLoading ?? this.isLoading,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      author: author ?? this.author,
      description: description ?? this.description,
      publisher: publisher ?? this.publisher,
      publishingYear: publishingYear ?? this.publishingYear,
      type: type ?? this.type,
      errTitle: errTitle ?? this.errTitle,
      errAuthor: errAuthor ?? this.errAuthor,
      errPublisher: errPublisher ?? this.errPublisher,
      errDescription: errDescription ?? this.errDescription,
    );
  }
}

class UpdateSuccessfulState extends ProductEditOverviewState {}
