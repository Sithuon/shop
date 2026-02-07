class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String category;
  final double oldPrice; // New field for old price
  bool isFavorite; // New field for favorite status
  final String description; // New field for product description

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.oldPrice, // Default value for old price
    this.isFavorite = false, // Default value for favorite status
    required this.description, // Default value for description
  });
  // Method to toggle favorite status
  void toggleFavorite() {
    isFavorite = !isFavorite;
    final index = products.indexWhere((p) => p.name == name);
    if (index != -1) {
      products[index] = copyWith(isFavorite: isFavorite);
    }
  }

  Product copyWith({bool? isFavorite}) {
    return Product(
      name: name,
      imageUrl: imageUrl,
      price: price,
      category: category,
      oldPrice: oldPrice,
      isFavorite: isFavorite ?? this.isFavorite,
      description: description,
    );
  }
}

// Add a method to toggle favorite status

List<Product> products = [
  Product(
    name: "Nike Sport Shoes",
    imageUrl: "/nike_sport_shoes.webp",
    price: 59.99,
    category: "Footwear",
    oldPrice: 79.99, // Example old price
    isFavorite: true,
    description: "High-quality sport shoes for all your athletic needs.",
  ),
  Product(
    name: "Nike Air Max",
    imageUrl: "/nike_blue.webp",
    price: 199.99,
    category: "Footwear",
    oldPrice: 249.99, // Example old price
    isFavorite: true,
    description: "Experience the ultimate comfort and style with Nike Air Max.",
  ),
  Product(
    name: "Nike Pink Sneakers",
    imageUrl: "/nike_pink.webp",
    price: 89.99,
    category: "Footwear",
    oldPrice: 119.99, // Example old price
    isFavorite: true,
    description: "Trendy pink sneakers perfect for casual wear.",
  ),
  Product(
    name: "KID001",
    imageUrl: "/K1.jpg",
    price: 9.99,
    category: "Kids",
    oldPrice: 14.99, // Example old price
    description: "Stylish kids' clothing perfect for everyday wear.",
  ),
  Product(
    name: "KID002",
    imageUrl: "/K2.jpg",
    price: 12.99,
    category: "Kids",
    oldPrice: 17.99, // Example old price
    description: "Comfortable and durable clothing for kids.",
  ),
  Product(
    name: "KID007",
    imageUrl: "/K7.jpg",
    price: 11.99,
    category: "Kids",
    oldPrice: 16.99, // Example old price
    description: "Fun and colorful clothing for children.",
  ),
  Product(
    name: "KID004",
    imageUrl: "/K4.jpg",
    price: 14.99,
    category: "Kids",
    oldPrice: 19.99, // Example old price
    description: "Stylish and affordable clothing for kids.",
  ),
  Product(
    name: "KID005",
    imageUrl: "/K5.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID006",
    imageUrl: "/K6.jpg",
    price: 15.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID008",
    imageUrl: "/K8.jpg",
    price: 11.99,
    category: "Kids",
    oldPrice: 19.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID009",
    imageUrl: "/K9.jpg",
    price: 14.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID010",
    imageUrl: "/K10.jpg",
    price: 12.99,
    category: "Kids",
    oldPrice: 15.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID011",
    imageUrl: "/K11.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID012",
    imageUrl: "/K12.jpg",
    price: 14.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID013",
    imageUrl: "/K13.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),

  Product(
    name: "KID014",
    imageUrl: "/K14.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID015",
    imageUrl: "/K15.jpg",
    price: 12.99,
    category: "Kids",
    oldPrice: 15.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID016",
    imageUrl: "/K16.jpg",
    price: 14.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID017",
    imageUrl: "/K17.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID018",
    imageUrl: "/K18.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID019",
    imageUrl: "/K19.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID020",
    imageUrl: "/K20.jpg",
    price: 14.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID021",
    imageUrl: "/K21.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID022",
    imageUrl: "/K22.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID024",
    imageUrl: "/K24.jpg",
    price: 10.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "Classic kids clothing.",
  ),
  Product(
    name: "KID025",
    imageUrl: "/K25.jpg",
    price: 13.99,
    category: "Kids",
    oldPrice: 18.99, // Example old price
    description: "classic clothing for kids.",
  ),
  Product(
    name: "MEN001",
    imageUrl: "/M1.jpg",
    price: 13.99,
    category: "Men",
    oldPrice: 18.99, // Example old price
    description: "comfortable clothing for men.",
  ),
];
