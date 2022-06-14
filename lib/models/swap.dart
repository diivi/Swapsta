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
  String? ownerPhone;
  //item details
  String requesterItemId;
  String requesterItemName;
  String requesterItemCover;
  double requesterItemCondition;
  String ownerItemId;
  String ownerItemName;
  String ownerItemCover;
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
    this.ownerPhone,
    required this.requesterItemId,
    required this.requesterItemName,
    required this.requesterItemCover,
    required this.requesterItemCondition,
    required this.ownerItemId,
    required this.ownerItemName,
    required this.ownerItemCover,
    required this.ownerItemCondition,
    this.isAccepted,
    this.createdAt,
    this.interactedAt,
    this.sharedContact,
  });
}
