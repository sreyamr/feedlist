import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:round2/provider/categorylist_provider.dart';
import 'package:round2/provider/home_provider.dart';

import '../config/approutes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryList = Provider.of<CategoryProvider>(context, listen: false);
      categoryList.getCategoryList();
      final homeProvider = Provider.of<FeedListProvider>(context, listen: false);
      homeProvider.getFeedList();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Consumer<FeedListProvider>(
        builder: (context, feedListProvider, child) {

          if (feedListProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (feedListProvider.feedList.isEmpty) {
            return const Center(child: Text("No feed data available"));
          }

          return ListView.builder(
            itemCount: feedListProvider.feedList.length,
            itemBuilder: (context, index) {
              final feedItem = feedListProvider.feedList[index];
              final result = feedItem.results?.isNotEmpty == true ? feedItem.results![0] : null;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(
                    result!.image.toString(),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(result!.description.toString()),
                 // subtitle: Text('Likes: ${feedItem.likes.length}'),
                  onTap: () {
                    // Handle item tap, if needed
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.addFeed);
      },
      icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      label: Text(
        'Add',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
