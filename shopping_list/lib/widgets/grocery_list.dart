import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/data/realtime_database.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  late Future<List<GroceryItem>> _loadedItems;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(baseUrl, "shopping-list.json");

    final res = await http.get(
      url,
    );

    if (res.statusCode >= 400) {
      throw Exception("Failed to fetch grocery items. Please try again later.");
    }

    if (res.body == "Null") {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(
      res.body,
    );

    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere((cat) => cat.value.title == item.value["category"])
          .value;

      loadedItems.add(
        GroceryItem(
            id: item.key,
            name: item.value["name"],
            quantity: item.value["quantity"],
            category: category),
      );
    }
    return loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const NewItem();
        },
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item, int index) async {
    setState(() {
      _groceryItems.removeAt(index);
    });

    final url = Uri.https(baseUrl, "shopping-list/${item.id}.json");

    final res = await http.delete(url);

    if (res.statusCode >= 400) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cnnnot delete the item")));

      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("No items added yet."));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Dismissible(
                key: ValueKey(snapshot.data![index].id),
                onDismissed: (direction) =>
                    _removeItem(snapshot.data![index], index),
                child: ListTile(
                  title: Text(snapshot.data![index].name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: snapshot.data![index].category.color,
                  ),
                  trailing: Text(
                    snapshot.data![index].quantity.toString(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
