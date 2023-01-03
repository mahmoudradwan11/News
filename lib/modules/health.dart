import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/component/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
class HealthNews extends StatelessWidget {
  const HealthNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){},
        builder:(context,state)
        {
          var cubit = NewsCubit.get(context);
          var healthNews = cubit.health;
            return ListView.separated(
                itemBuilder:(context,index)=>builtNewsItem(healthNews[index],context),
                separatorBuilder:(context,index)=>Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                itemCount: healthNews.length,
            );
        },
    );
  }
}
