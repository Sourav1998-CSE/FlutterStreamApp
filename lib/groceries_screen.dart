import 'package:flutter/material.dart';
import 'repository.dart';

class GroceriesScreen extends StatelessWidget {
  final Repository repository;

  GroceriesScreen({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Groceries')),
      body: StreamBuilder<List<String>>(
        stream: repository.groceriesStream,
        builder: (context, snapshot) {
          print('Groceries StreamBuilder state: ${snapshot.connectionState}');
          print('Groceries StreamBuilder data: ${snapshot.data}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final groceries = snapshot.data ?? [];

          if (groceries.isEmpty) {
            return Center(child: Text('No groceries yet!'));
          }

          return ListView.builder(
            itemCount: groceries.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(groceries[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    repository.removeGrocery(groceries[index]);
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
          repository.addGrocery('Grocery ${DateTime.now()}');
        },
      ),
    );
  }
}
