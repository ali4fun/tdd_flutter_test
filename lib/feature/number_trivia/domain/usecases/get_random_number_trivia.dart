import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tddapp/core/error/failures.dart';
import 'package:tddapp/core/usecases/usecase.dart';
import 'package:tddapp/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddapp/feature/number_trivia/domain/respositries/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {

  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>?> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }

}

class NoParams extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();
}