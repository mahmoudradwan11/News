//import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business.dart';
import 'package:news/modules/health.dart';
import 'package:news/modules/sports.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInitState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0 ;
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> health = [];
  List<dynamic> search = [];
  List<Widget>screens=const[
    BusinessNews(),
    SportsNews(),
    HealthNews(),
  ];
  bool dark = false;
  List<BottomNavigationBarItem>bottomItems =const[
    BottomNavigationBarItem(
      icon:Icon(
        Icons.business,
      ),
      label:'Business',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.sports,
      ),
      label:'sports',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.health_and_safety,
      ),
      label:'Health',
    ),
  ];
  void changeItem(index)
  {
     currentIndex = index;
     emit(ChangeIndexState());
  }

  void getBusinessData()
  {
      DioHelper.getData(
          url:'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'business',
            'apiKey':'6c13d55401484eb49c81a4bca91ed2e5'
          }
      ).
      then((value){
         business = value.data['articles'];
         print(business[0]['title']);
         emit(GetBusinessData());
      }).catchError((error){
          print(error.toString());
          emit(ErrorBusinessData());
      });
  }
  void getSportsData()
  {
     DioHelper.getData(
         url:'v2/top-headlines',
         query:
         {
           'country':'eg',
           'category':'sports',
           'apiKey':'6c13d55401484eb49c81a4bca91ed2e5'
         }
     ).then((value){
       sports = value.data['articles'];
       emit(GetSportsData());
     }).catchError((error){
       print(error.toString());
       emit(ErrorSportsData());
     });
  }
  void getHealthData()
  {
    DioHelper.getData(
        url:'v2/top-headlines',
        query:
        {
          'country':'eg',
          'category':'health',
          'apiKey':'6c13d55401484eb49c81a4bca91ed2e5'
        }
    ).then((value){
      health = value.data['articles'];
      emit(GetHealthData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorHealthData());
    });
  }
  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      dark = fromShared;
      emit(ChangeAppMode());
    }
    else
    {
      dark = !dark;
      CacheHelper.putBooleanData(key: 'mode', value:dark).then((value) {
        emit(ChangeAppMode());
      });
    }
  }
  void searchNews({required String searchWord})
  {
     search = [];
     DioHelper.getData(
         url:'v2/everything',
         query:{
       'q':searchWord,
       'apiKey':'6c13d55401484eb49c81a4bca91ed2e5'
         }
     ).then((value){
       search = value.data['articles'];
       emit(SearchState());
     }).catchError((error){
       print(error.toString());
       emit(ErrorSearch());
     });
  }
}