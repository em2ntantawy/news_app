import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components.dart';
import 'package:path/path.dart';

class Search extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var searchController = TextEditingController();

        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  //keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(color: Color.fromARGB(255, 114, 21, 21)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Search',
                    // fillColor: Colors.black,
                    prefixIcon: Icon(Icons.search),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter some text';
                  //   }
                  //   return null;
                  // },
                  onFieldSubmitted: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(child: ArticleBuilder(list, context)),
            ], // onChanged: (value) {
            //   // TextInputType.text;
            //   //TextStyle(color: Colors.black);
            //   NewsCubit.get(context).getSearch(value);
            //   Colors.blue;
            // },
          ),
        );
      },
    );
  }
}
