import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddapp/feature/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel>? getLastNumberTrivia();
  Future<void>? cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
   SharedPreferences sharedPreferences ;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel>? getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  // Future<bool> isFirst = await getIsFirstTime();

// Future<bool> getIsFirstTime() async {
//   final prefs = await SharedPreferences.getInstance();
//   final isFirst = prefs.getBool('isFirstInstall') ?? false;
//   print("get value is:>> "+isFirst.toString());
//   return isFirst;

  @override
  Future<bool>? cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    debugger();
    return sharedPreferences.setString(
        CACHED_NUMBER_TRIVIA, '');
  }
}