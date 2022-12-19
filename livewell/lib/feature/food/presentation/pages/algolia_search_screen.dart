import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:flutter/material.dart';

class AlgoliaSearchScreen extends StatefulWidget {
  const AlgoliaSearchScreen({super.key});

  @override
  State<AlgoliaSearchScreen> createState() => _AlgoliaSearchScreenState();
}

class _AlgoliaSearchScreenState extends State<AlgoliaSearchScreen> {
  // 1. Create a Hits Searcher
  final hitsSearcher = HitsSearcher(
    applicationID: 'JTCO4LVZ9P',
    apiKey: '7604aab9adfbe627a8f4ccde0902e2e0',
    indexName: 'dev_food_directory',
  );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // 2. Run your search operations
          title: TextField(
            onChanged: (input) => hitsSearcher.query(input),
            decoration: const InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
        // 3.1 Listen to search responses
        body: StreamBuilder<SearchResponse>(
          stream: hitsSearcher.responses,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final response = snapshot.data;
              final hits = response?.hits.toList() ?? [];
              // 3.2 Display your search hits
              if (hits.isNotEmpty) {
                return ListView.builder(
                  itemCount: hits.length,
                  itemBuilder: (_, i) =>
                      ListTile(title: Text(hits[i]['food_name'] ?? "")),
                );
              } else {
                return Container();
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );

  @override
  void dispose() {
    super.dispose();
    // 4. Release underling resources
    hitsSearcher.dispose();
  }
}

class SearchMetadata {
  final int nbHits;

  const SearchMetadata(this.nbHits);

  factory SearchMetadata.fromResponse(SearchResponse response) =>
      SearchMetadata(response.nbHits);
}

class HitsPage {
  const HitsPage(this.items, this.pageKey, this.nextPageKey);

  final List<Product> items;
  final int pageKey;
  final int? nextPageKey;

  factory HitsPage.fromResponse(SearchResponse response) {
    final items = response.hits.map(Product.fromJson).toList();
    final isLastPage = response.page >= response.nbPages;
    final nextPageKey = isLastPage ? null : response.page + 1;
    return HitsPage(items, response.page, nextPageKey);
  }
}

class Product {
  final String name;
  final String image;

  Product(this.name, this.image);

  static Product fromJson(Map<String, dynamic> json) {
    return Product(json['name'], json['image_urls'][0]);
  }
}
