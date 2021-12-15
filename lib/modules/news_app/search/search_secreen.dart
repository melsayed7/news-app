
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
 var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list =NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFeild(
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    onchange: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate:(value){
                      if(value!.isEmpty)
                      {
                        return('search must not be empty');
                      }
                    }
                ),
              ),
              Expanded(child: articleBuilder(list, context , isSearch: true,),),
            ],
          ),
        );
      },
    );
  }
}
