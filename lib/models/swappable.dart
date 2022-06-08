class Swappable {
  final String id;
  final String name;
  final List<String> imageUrls;
  final String description;
  final String category;
  final String ownerName;
  final String ownerImageUrl;
  final double condition;
  final DateTime createdAt;
  final DateTime updatedAt;
  bool isWishlisted;

  Swappable({
    required this.id,
    required this.name,
    required this.imageUrls,
    required this.description,
    required this.category,
    required this.ownerName,
    required this.ownerImageUrl,
    required this.condition,
    required this.createdAt,
    required this.updatedAt,
    this.isWishlisted = false,
  });
}
