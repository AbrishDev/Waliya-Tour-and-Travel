class Book {
  List<String> visitors;
  String date;
  bool isPrivate;
  String siteName;
  String guidePhoneNumber;
  String status;

  Book({
    required this.visitors,
    required this.date,
    required this.isPrivate,
    required this.siteName,
    required this.guidePhoneNumber,
    required this.status,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      visitors: List<String>.from(json['visitors']),
      date: json['date'],
      isPrivate: json['isPrivate'],
      siteName: json['siteName'],
      guidePhoneNumber: json['guidePhoneNumber'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitors': visitors,
      'date': date,
      'isPrivate': isPrivate,
      'siteName': siteName,
      'guidePhoneNumber': guidePhoneNumber,
      'status': status,
    };
  }
}
