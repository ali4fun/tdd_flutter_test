import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/testing.dart';
import 'package:tddapp/feature/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/error/exceptions.dart';

import 'package:http/http.dart' as http;

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('this is number result :'+ response.body + response.body.split(' ')[0]);
      return NumberTriviaModel.fromJson({'text' : response.body,'number' : int.parse(response.body.split(' ')[0])});
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number) =>
       _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel>? getRandomNumberTrivia() =>
      _getTriviaFromUrl('http://numbersapi.com/random');
}

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number);

  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel>? getRandomNumberTrivia();
}