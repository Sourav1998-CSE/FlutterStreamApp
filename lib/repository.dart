import 'dart:async';

class Repository {
  final _groceriesController = StreamController<List<String>>.broadcast();
  final _bookmarksController = StreamController<List<String>>.broadcast();

  final List<String> _groceries = [];
  final List<String> _bookmarks = [];

  Repository() {
    _groceriesController.sink.add(List.from(_groceries)); // Emit initial state
    _bookmarksController.sink.add(List.from(_bookmarks)); // Emit initial state
  }

  // Streams to listen for updates
  Stream<List<String>> get groceriesStream => _groceriesController.stream;
  Stream<List<String>> get bookmarksStream => _bookmarksController.stream;

  // Methods to add items to grocery and bookmark lists
  void addGrocery(String grocery) {
    _groceries.add(grocery);
    print('Adding grocery: $grocery'); // Debug log
    _groceriesController.sink.add(List.from(_groceries)); // Emit updated list
  }

  void removeGrocery(String grocery) {
    _groceries.remove(grocery);
    print('Removing grocery: $grocery'); // Debug log
    _groceriesController.sink.add(List.from(_groceries)); // Emit updated list
  }

  void addBookmark(String bookmark) {
    _bookmarks.add(bookmark);
    print('Adding bookmark: $bookmark'); // Debug log
    _bookmarksController.sink.add(List.from(_bookmarks)); // Emit updated list
  }

  void removeBookmark(String bookmark) {
    _bookmarks.remove(bookmark);
    print('Removing bookmark: $bookmark'); // Debug log
    _bookmarksController.sink.add(List.from(_bookmarks)); // Emit updated list
  }
}
