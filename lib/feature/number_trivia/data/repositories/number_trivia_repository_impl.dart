import 'package:tddapp/core/platform/network_info.dart';
import 'package:tddapp/feature/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:tddapp/feature/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:tddapp/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tddapp/feature/number_trivia/domain/respositries/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;


  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo
  });
  @override
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(int number) {
   return null;
  }

  @override
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia() {
   return null;
  }
  
}