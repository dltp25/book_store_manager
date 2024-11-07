class ProductCreateModel {
  final String title;
  final String author;
  final String publisher;
  final String publishingYear;
  final String type;
  final String description;
  final double price;
  final double discount;

  ProductCreateModel({
    required this.title,
    required this.author,
    required this.publisher,
    required this.publishingYear,
    required this.type,
    required this.description,
    required this.price,
    required this.discount,
  });

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'description': description,
      'discount': discount,
      'price': price,
      'publisher': publisher,
      'publishingYear': publishingYear,
      'type': type,
      'title': title,
    };
  }
}
