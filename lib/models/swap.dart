class Swap {
  String id;
  //owner details
  String requesterId;
  String requesterName;
  String requesterImage;
  String requesterPhone;
  String ownerId;
  String ownerName;
  String ownerImage;
  //item details
  String requesterItemId;
  String requesterItemName;
  List<String> requesterItemImages;
  String requesterItemDescription;
  String requesterItemCategory;
  DateTime requesterItemCreatedAt;
  DateTime requesterItemUpdatedAt;
  double requesterItemCondition;
  String ownerItemId;
  String ownerItemName;
  List<String> ownerItemImages;
  String ownerItemDescription;
  String ownerItemCategory;
  DateTime ownerItemCreatedAt;
  DateTime ownerItemUpdatedAt;
  double ownerItemCondition;
  //swap details
  bool? isAccepted = false;
  DateTime? createdAt = DateTime.now();
  DateTime? interactedAt;
  bool? sharedContact = false;

  Swap({
    required this.id,
    required this.requesterId,
    required this.requesterName,
    required this.requesterImage,
    required this.requesterPhone,
    required this.ownerId,
    required this.ownerName,
    required this.ownerImage,
    required this.requesterItemId,
    required this.requesterItemName,
    required this.requesterItemImages,
    required this.requesterItemDescription,
    required this.requesterItemCategory,
    required this.requesterItemCreatedAt,
    required this.requesterItemUpdatedAt,
    required this.requesterItemCondition,
    required this.ownerItemId,
    required this.ownerItemName,
    required this.ownerItemImages,
    required this.ownerItemDescription,
    required this.ownerItemCategory,
    required this.ownerItemCreatedAt,
    required this.ownerItemUpdatedAt,
    required this.ownerItemCondition,
    this.isAccepted,
    this.createdAt,
    this.interactedAt,
    this.sharedContact,
  });
}
