import 'package:flutter/material.dart';
import 'package:project_2/Building_data.dart';

class Search_page extends SearchDelegate {
  building_data data = building_data();

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: Icon(Icons.clear),
        )
      ];

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> suggestions = data.get_buildingName().where((searchResult){
      return searchResult.contains(query);
    }).toList();//검색창에 글자를 넣을때 마다 리스트에 그 글자와 관련된 내용이 있으면 리스트에 추가

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
