import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tddapp/feature/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/number_trivia.dart';

import 'package:http/http.dart' as http;

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
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

  /// Throws a [ServerExcaption] for all error codes.
  Future<NumberTriviaModel>? getRandomNumberTrivia();
}