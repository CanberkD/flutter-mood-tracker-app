class InfogramModel {
  late final String _title;
  late final List<String> _items;
  InfogramModel({required String title, required List<String> items}) : _title = title, _items = items;

  void setTitle(String title) => _title = title;
  String get getTitle => _title; 

  void setItems(List<String> items) => _items = items;
  List<String> get getItems => _items;
}