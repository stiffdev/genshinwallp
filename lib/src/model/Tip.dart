class Tips {
  List<Tip> items = [];

  Tips();

  Tips.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final tip = new Tip.fromJsonMap(item);
      items.add(tip);
    }
  }
}

class Tip {
  String? title;
  String? image;
  String? text;
  String? uniqueId;

  Tip({
    this.title,
    this.image,
    this.text,
    this.uniqueId,
  });

  Tip.fromJsonMap(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    text = json['text'];
    uniqueId = json['uniqueId'];
  }
}
