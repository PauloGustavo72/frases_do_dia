class Phrase {
  int id;
  String phrase;

  Phrase(this.id, this.phrase);

  Phrase.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phrase = json['phrase'];
}
