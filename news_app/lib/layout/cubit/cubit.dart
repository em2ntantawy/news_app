import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/Network/local/cache_helper.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business.dart';
import 'package:news_app/modules/science.dart';
import 'package:news_app/modules/sports.dart';

import '../Network/Remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Sciencs'),
  ];
  List<Widget> Screens = [Business(), Sports(), Science()];

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '6ecafaaf403648a29e7735c6a445d064 '
    }).then((value) {
      print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErorrState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: '/v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '6ecafaaf403648a29e7735c6a445d064 '
      }).then((value) {
        print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErorrState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSucessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: '/v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '6ecafaaf403648a29e7735c6a445d064 '
      }).then((value) {
        print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSucessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErorrState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSucessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsSearchLoadingState());
    search = [];
    DioHelper.getData(url: '/v2/everything', query: {
      'q': '$value',
      'apiKey': '6ecafaaf403648a29e7735c6a445d064 '
    }).then((value) {
      print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErorrState(error.toString()));
    });

    emit(NewsGetSearchSucessState());
  }

  Void? ChangeBottomNavBar(int index) {
    currentIndex = index;
    // if (index == 1) getSports();
    //if (index == 2) getScience();

    emit(NewsBottomNavState());
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null)
      isDark = fromShared;
    else
      isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });
    print(isDark);
  }
}
