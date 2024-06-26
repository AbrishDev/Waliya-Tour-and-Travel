class Tour {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final int price;
  final int people;
  final String description;
  final String guideName;

  Tour({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.people,
    required this.description,
    required this.guideName,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['_id'],
      name: json['name'],
      location: json['location'],
      imageUrl: json['image'],
      price: json['price'],
      people: json['people'],
      description: json['description'],
      guideName: json['guideName'],
    );
  }
}
