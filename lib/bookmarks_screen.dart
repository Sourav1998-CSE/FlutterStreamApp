import 'package:flutter/material.dart';
import 'repository.dart';

class BookmarksScreen extends StatelessWidget {
  final Repository repository;

  BookmarksScreen({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarks')),
      body: StreamBuilder<List<String>>(
        stream: repository.bookmarksStream,
        builder: (context, snapshot) {
          print('Bookmarks StreamBuilder state: ${snapshot.connectionState}');
          print('Bookmarks StreamBuilder data: ${snapshot.data}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final bookmarks = snapshot.data ?? [];

          if (bookmarks.isEmpty) {
            return Center(child: Text('No bookmarks yet!'));
          }

          return ListView.builder(
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(bookmarks[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    repository.removeBookmark(bookmarks[index]);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          repository.addBookmark('Bookmark ${DateTime.now()}');
        },
      ),
    );
  }
}
