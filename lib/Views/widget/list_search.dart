import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/models/data_model.dart';

class ListSearch extends SearchDelegate<DataModel?> {
  final List<DataModel> list;

  ListSearch({
    required this.list,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchBody(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchBody(context);
  }

  Widget buildSearchBody(BuildContext context) {
    List<DataModel> tempList = [];

    if (query.isEmpty) {
      tempList = list;
    } else {
      for (var element in list) {
        if (element.state.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(element);
        }
      }
    }

    if (tempList.isEmpty) {
      return const Center(
        child: Text("No results"),
      );
    }

    return ListView.builder(
      itemCount: tempList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${tempList[index].state}     ${tempList[index].year}"),
        );
      },
    );
  }
}
