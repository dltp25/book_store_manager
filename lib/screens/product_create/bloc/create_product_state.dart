part of 'create_product_bloc.dart';

class CreateProductState extends Equatable {
  final String productTitle;
  final String titleErr;
  final String author;
  final String authorErr;
  final BookType type;
  final String publisher;
  final String publisherErr;
  final String publishingYear;
  final String description;
  final String descriptionErr;
  final double price;
  final double discount;
  final String priceErr;
  final String discountErr;
  final List<File> images;
  final String imageErr;

  const CreateProductState({
    this.productTitle = '',
    this.titleErr = '',
    this.author = '',
    this.authorErr = '',
    this.type = BookType.other,
    this.publisher = '',
    this.publisherErr = '',
    this.publishingYear = '2023',
    this.description = '',
    this.descriptionErr = '',
    this.price = 0,
    this.discount = 0,
    this.priceErr = '',
    this.discountErr = '',
    this.images = const [],
    this.imageErr = '',
  });

  @override
  List<Object> get props => [
        productTitle,
        titleErr,
        author,
        authorErr,
        type,
        publisher,
        publisherErr,
        publishingYear,
        description,
        descriptionErr,
        price,
        discount,
        priceErr,
        discountErr,
        images,
        imageErr,
      ];

  CreateProductState copyWith({
    String? productTitle,
    String? titleErr,
    String? author,
    String? authorErr,
    BookType? type,
    String? publisher,
    String? publisherErr,
    String? publishingYear,
    String? description,
    String? descriptionErr,
    double? price,
    double? discount,
    String? priceErr,
    String? discountErr,
    List<File>? images,
    String? imageErr,
  }) {
    return CreateProductState(
      productTitle: productTitle ?? this.productTitle,
      titleErr: titleErr ?? this.titleErr,
      author: author ?? this.author,
      authorErr: authorErr ?? this.authorErr,
      type: type ?? this.type,
      publisher: publisher ?? this.publisher,
      publisherErr: publisherErr ?? this.publisherErr,
      publishingYear: publishingYear ?? this.publishingYear,
      description: description ?? this.description,
      descriptionErr: descriptionErr ?? this.descriptionErr,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      priceErr: priceErr ?? this.priceErr,
      discountErr: discountErr ?? this.discountErr,
      images: images ?? this.images,
      imageErr: imageErr ?? this.imageErr,
    );
  }
}

class CreateSuccessState extends CreateProductState {}
