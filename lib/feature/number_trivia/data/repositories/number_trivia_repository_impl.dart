import 'package:tddapp/core/error/exceptions.dart';
import 'package:tddapp/core/platform/network_info.dart';
import 'package:tddapp/feature/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:tddapp/feature/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:tddapp/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:tddapp/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tddapp/feature/number_trivia/domain/respositries/number_trivia_repository.dart';

typedef Future<NumberTriviaModel>? _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource? remoteDataSource;
  final NumberTriviaLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, NumberTrivia>>? getConcreteNumberTrivia(
      int number) async {
   return await _getTrivia((){
     return remoteDataSource?.getConcreteNumberTrivia(number);
   });
  }

  @override
  Future<Either<Failure, NumberTrivia>>? getRandomNumberTrivia() async {
   return await _getTrivia((){
     return remoteDataSource?.getRandomNumberTrivia();
   });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom
  ) async{
    if (await (networkInfo?.isConnected)!) {
      try {
        final remoteTrivia =
            await getConcreteOrRandom();
        localDataSource?.cacheNumberTrivia(remoteTrivia!);
        return right(remoteTrivia!);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource?.getLastNumberTrivia();
        return Right(localTrivia!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
