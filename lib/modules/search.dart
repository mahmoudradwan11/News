import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/component/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class Search extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){},
      builder:(context,state){
        var cubit = NewsCubit.get(context);
        List searchNews = cubit.search;
        return Scaffold(
          appBar: AppBar(),
          body:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller:searchController,
                      decoration:InputDecoration(
                        suffixIcon:const Icon(Icons.search),
                        border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(30),
                        ),
                        labelText:'Search',
                      ),
                      keyboardType: TextInputType.text,
                      obscureText:false,
                      style:Theme.of(context).textTheme.bodyText1,
                      onChanged:(value){
                        cubit.searchNews(searchWord: value);
                      },
                    ),
                    ListView.separated(
                        shrinkWrap:true,
                        physics:const NeverScrollableScrollPhysics(),
                        itemBuilder:(context,index)=>builtNewsItem(searchNews[index],context),
                        separatorBuilder:(context,index)=>Container(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        itemCount:searchNews.length,
                    ),
                  ],
                ),
            ),
            ),
        );
      },
    );
  }
}
