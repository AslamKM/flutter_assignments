import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/data_bloc.dart';
import '../../core/models/data_model.dart';
import 'list_search.dart';

class HomeSub extends StatefulWidget {
  final List<DataModel> list;
  const HomeSub({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  State<HomeSub> createState() => _HomeSubState();
}

class _HomeSubState extends State<HomeSub> {
  String dropDownvaluwe = 'Select State';
  String dropDownvaluwe1 = 'Select year';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                readOnly: true,
                decoration: const InputDecoration(hintText: "Search state"),
                onTap: () async {
                  await showSearch<DataModel?>(
                    context: context,
                    delegate: ListSearch(
                      list: BlocProvider.of<DataBloc>(context).list,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DropdownButton(
                hint: Text(
                  dropDownvaluwe,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                isExpanded: true,
                underline: Container(),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (DataModel? newValue) {
                  setState(() {
                    dropDownvaluwe = newValue!.state;
                    // _downModel = newValue;
                    // categoryselected = true;
                  });
                },
                items: BlocProvider.of<DataBloc>(context).list.map((items) {
                  return DropdownMenuItem(
                      onTap: () {
                        setState(() {
                          dropDownvaluwe = items.state;
                        });
                      },
                      value: items,
                      child: Text(items.state));
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DropdownButton(
                hint: Text(
                  dropDownvaluwe1,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                isExpanded: true,
                underline: Container(),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownvaluwe1 = newValue!;
                  });
                },
                items: [
                  '2021',
                  '2020',
                  '2019',
                  '2018',
                  '2017',
                ].map((items) {
                  return DropdownMenuItem(
                      onTap: () {
                        setState(() {
                          dropDownvaluwe1 = items;
                        });
                      },
                      value: items,
                      child: Text(items));
                }).toList(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (dropDownvaluwe == 'Select State' ||
                      dropDownvaluwe1 == 'Select year') {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please select date and year'),
                    ));
                  } else {
                    BlocProvider.of<DataBloc>(context).add(SearchDataEvent(
                        year: dropDownvaluwe1, state: dropDownvaluwe));
                  }
                },
                child: const Text("search")),
            const SizedBox(
              height: 30,
            ),
            const _ResultWidget(),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ],
    );
  }
}

class _ResultWidget extends StatelessWidget {
  const _ResultWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
        builder: ((BuildContext context, state) {
      if (state is DataLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is DataFetchSuccessState) {
        if (state.isSuccess) {
          List<DataModel> data = state.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("ID State"),
                            Text("State"),
                            Text("ID Year"),
                            Text("Year"),
                            Text("Population"),
                            Text("Slug State"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(":"),
                            Text(":"),
                            Text(":"),
                            Text(":"),
                            Text(":"),
                            Text(":"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[index].idState),
                            Text(data[index].state),
                            Text("${data[index].idYear}"),
                            Text(data[index].year),
                            Text("${data[index].population}"),
                            Text(data[index].slugState),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      } else if (state is DataFetchFailedState) {
        return Center(
          child: Text(state.error),
        );
      } else {
        return const Center(
          child: Text("Some Error occurred"),
        );
      }
    }));
  }
}
