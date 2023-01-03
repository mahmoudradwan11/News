import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/home.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';
void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? mode = CacheHelper.getBooleanData(key:'mode');
  runApp(MyApp(mode));
}
class MyApp extends StatelessWidget {
  final bool? appMode;
  MyApp(this.appMode);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>NewsCubit()..getBusinessData()..getSportsData()..getHealthData()..changeMode(
        fromShared: appMode,
      ),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){},
        builder:(context,state){
          var cubit = NewsCubit.get(context);
          return MaterialApp(
            theme:ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme:const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  //backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness:Brightness.dark,
                  ),
                  titleTextStyle: TextStyle(
                    color:Colors.deepOrange,
                    fontSize: 25,
                    fontWeight:FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                    size:25,
                  )
              ),
              bottomNavigationBarTheme:const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 0.0,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.black,
              ),
              textTheme:const TextTheme(
                bodyText1:TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor:HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              appBarTheme:AppBarTheme(
                  backgroundColor: HexColor('333739'),
                  elevation: 0.0,
                  //backwardsCompatibility: false,
                  systemOverlayStyle:SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness:Brightness.light,
                  ),
                  titleTextStyle:const TextStyle(
                    color:Colors.white,
                    fontSize: 25,
                    fontWeight:FontWeight.bold,
                  ),
                  iconTheme:const IconThemeData(
                    color: Colors.white,
                    size:25,
                  )
              ),
              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 0.0,
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.white,
              ),
              textTheme:const TextTheme(
                bodyText1:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            themeMode:cubit.dark ? ThemeMode.dark:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:const Directionality(
                textDirection: TextDirection.ltr,
                child:NewsHome(),
            ),
          );
        },
      ),
    );
  }
}
