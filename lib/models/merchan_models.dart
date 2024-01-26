class MerchantModels {
  int? id;
  String? name;
  String? address;
  double? long;
  double? lat;
  String? image;

  MerchantModels({
    this.id,
    this.name,
    this.address,
    this.image,
    this.lat,
    this.long,
  });

  MerchantModels.fromJson(Map<String, dynamic> json) {
    id = json['merchantId'];
    name = json['merchantName'];
    address = json['merchantAddress'];
    long = double.parse(json['long']);
    lat = double.parse(json['lat']);
    image = json['image'];
  }
}
