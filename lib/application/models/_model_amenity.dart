enum CostType {
  slotBased,
  hourBased,
}

class Amenity {
  final String amenity, imgUrl;
  final CostType costType;
  final double cost;
  final bool isAvailable;

  const Amenity({
    required this.amenity,
    required this.imgUrl,
    required this.costType,
    required this.cost,
    required this.isAvailable,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      amenity: json['amenity'],
      imgUrl: json['imgUrl'],
      costType: getCostType(json['costType']),
      cost: json['cost'],
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amenity': amenity,
      'imgUrl': imgUrl,
      'costType': costType.toString(),
      'cost': cost,
      'isAvailable': isAvailable,
    };
  }

  static CostType getCostType(String val) {
    if (val == CostType.slotBased.toString()) {
      return CostType.slotBased;
    }
    return CostType.hourBased;
  }
}
