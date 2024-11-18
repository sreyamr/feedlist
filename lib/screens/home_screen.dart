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
      //  final categoryList = Provider.of<CategoryProvider>(context, listen: false);
      // categoryList.getCategoryList();
      final homeProvider = Provider.of<FeedListProvider>(context, listen: false);
      homeProvider.getFeedList();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
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
              print(feedItem);
              return ListTile(
                contentPadding: EdgeInsets.all(8.0),
                title: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      feedItem.image!.isNotEmpty
                          ? Image.network(
                        feedItem.image.toString(),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : const Icon(Icons.image, size: 100),
                      const SizedBox(height: 8),
                      Text(
                        feedItem.description.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  ///  _buildFloatingActionButton
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
      backgroundColor: Colors.red.shade900,
    );
  }

}
