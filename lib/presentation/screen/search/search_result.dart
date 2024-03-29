import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

class SearchResult extends SearchDelegate<String> {
   final cities = [
      'City 1',
      'City 2',
      'City 3',
      // Add as many city names as you need
   ];

   final recentCities = [
      'City 1',
      'City 2',
   ];
   
  @override
  ThemeData appBarTheme(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return theme.copyWith(
    scaffoldBackgroundColor: AppMuixTheme.backgroundSecondary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppMuixTheme.background,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppMuixTheme.textUrbanistBold15
    )
  );
}

   @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.red,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
      ? recentCities
      : cities.where((c) => c.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: const Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}