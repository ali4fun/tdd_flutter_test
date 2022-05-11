import 'package:dartz/dartz.dart';
import 'package:tddapp/feature/number_trivia/data/models/number_trivia_model.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaRemoteDataSource {

  /// Throws a [ServerExcaption] for all error codes.
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number);

  /// Throws a [ServerExcaption] for all error codes.
  Future<NumberTriviaModel>? getRandomNumberTrivia();
}