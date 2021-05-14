class ResponceDogs {
  final Map<String, List<String>> message;
  final String status;

  ResponceDogs({this.message, this.status});

  factory ResponceDogs.fromJson(Map<String, dynamic> json) {
    return ResponceDogs(
      message: (json['message'] as Map)
          .map((key, value) => MapEntry(key, List<String>.from(value))),
      status: json['status'],
    );
  }
}

class Dogs {
  final String breed;
  final List<String> subBreeds;

  Dogs({this.breed, this.subBreeds});
}
