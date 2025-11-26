class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final double rating;
  final String? vendor;
  final String? partNumber;
  final int? stock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
    this.vendor,
    this.partNumber,
    this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle rating - it's nested in an object with 'rate' and 'count'
    double ratingValue = 0.0;
    final ratingData = json['rating'];
    if (ratingData is Map) {
      ratingValue = (ratingData['rate'] as num?)?.toDouble() ?? 0.0;
    } else if (ratingData is num) {
      ratingValue = ratingData.toDouble();
    }
    
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      rating: ratingValue,
      vendor: json['vendor'] ?? 'Premium Auto Parts',
      partNumber: json['partNumber'] ?? 'PN-${json['id']}',
      stock: json['stock'] ?? 10,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': rating,
      'vendor': vendor,
      'partNumber': partNumber,
      'stock': stock,
    };
  }
}
