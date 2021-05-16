class Cat {
  final String text;
  final String repository;

  Cat({this.text, this.repository});

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      text: json['text'],
      repository:
          json['repository'] == null ? 'публичного API' : json['repository'],
    );
  }
}
