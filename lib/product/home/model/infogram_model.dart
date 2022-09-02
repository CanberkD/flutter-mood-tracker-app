class InfogramModel {
  late final String _title;
  late final List<String> _items;
  InfogramModel({required String title, required List<String> items}) : _title = title, _items = items;

  String get getTitle => _title; 

  List<String> get getItems => _items;

}