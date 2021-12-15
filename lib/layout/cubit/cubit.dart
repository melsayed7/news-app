import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/news_app/business/business_screen.dart';
import 'package:news_app/modules/news_app/science/science.dart';
import 'package:news_app/modules/news_app/sports/sports.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> Screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar (int index){
    currentIndex = index ;
    if(index == 0)
      getBusiness();
    if(index == 1)
      getSport();
    if (index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business =[];

  void getBusiness(){

    //emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country' : 'us',
            'category' : 'business',
            'apiKey' : '2e8b89193da249e5a3d8e9c11cf911ae',
          },
        ).then((value) {
          print(value.data['articles'][0]['title']);
          business = value.data['articles'] ;
          print(business[0]['title']);
          emit(NewsGetBusinessSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetBusinessErrorState(error.toString()));
        });

  }

  List<dynamic> sport =[];

  void getSport(){

    emit(NewsGetSportLoadingState());

      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': '2e8b89193da249e5a3d8e9c11cf911ae',
        },
      ).then((value) {
        print(value.data['articles'][0]['title']);
        sport = value.data['articles'];
        print(sport[0]['title']);
        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportErrorState(error.toString()));
      });

  }

  List<dynamic> science =[];

  void getScience(){

    emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': '2e8b89193da249e5a3d8e9c11cf911ae',
        },
      ).then((value) {
        print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });

  }


  List<dynamic> search =[];

  void getSearch(value){

    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '2e8b89193da249e5a3d8e9c11cf911ae',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }

}