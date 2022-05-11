import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/number_trivia.dart';
import '../respositries/number_trivia_repository.dart';

class GetConcreateNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreateNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>?> execute({required int number}) async {
    return await repository.getConcreteNumberTrivia((number));
  }
}
