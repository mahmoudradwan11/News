import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business.dart';
import 'package:news/modules/search.dart';
import 'package:news/shared/component/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){},
        builder:(context,state){
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:const Text('News '),
              titleSpacing: 20,
              actions: [
                IconButton(onPressed:(){
                  navigateTo(context, Search());
                },
                    icon:const Icon(Icons.search)
                ),
                IconButton(
                  onPressed:(){
                    cubit.changeMode();
                  },
                  icon:const Icon(
                      Icons.dark_mode
                  ),
                )
              ],
            ),
            body:cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap:(index)
              {
                cubit.changeItem(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      );
  }
}
