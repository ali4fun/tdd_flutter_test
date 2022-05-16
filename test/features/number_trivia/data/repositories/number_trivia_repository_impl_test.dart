import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddapp/core/error/exceptions.dart';
import 'package:tddapp/core/error/failures.dart';
import 'package:tddapp/core/platform/network_info.dart';
import 'package:tddapp/feature/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:tddapp/feature/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:tddapp/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:tddapp/feature/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tddapp/feature/number_trivia/domain/entities/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl? repository;
  MockRemoteDataSource? mockRemoteDataSource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo?.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo?.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: 'test trivia');
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    // test('should check if the device is online', () async {
    //   //arrange
    //   when(mockNetworkInfo?.isConnected).thenAnswer((_) async => true);
    //   //act
    //   repository?.getConcreteNumberTrivia(tNumber);
    //   //assert
    //   verify(mockNetworkInfo?.isConnected);
    // });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource?.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository?.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource?.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(tNumberTrivia)));
      });

      test(
          'should cache the data locallay when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource?.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        await repository?.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource?.getConcreteNumberTrivia(tNumber));
        verify(mockLocalDataSource?.cacheNumberTrivia(tNumberTriviaModel));
      });
      test(
          'should return SERVER FAILURE when the call to remote data source is UNsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource?.getConcreteNumberTrivia(tNumber))
            .thenThrow(ServerException());
        //act
        final result = await repository?.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockRemoteDataSource?.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline( () {
      test('should return ', () async {
        when(mockLocalDataSource?.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository?.getConcreteNumberTrivia(tNumber);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource?.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test('should return cacheFailure when there is no cached data present.',
          () async {
        when(mockLocalDataSource?.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repository?.getConcreteNumberTrivia(tNumber);
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource?.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(number: 123, text: 'test trivia');
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo?.isConnected).thenAnswer((_) async => true);
      //act
      repository?.getRandomNumberTrivia();
      //assert
      verify(mockNetworkInfo?.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource?.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository?.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource?.getRandomNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test(
          'should cache the data locallay when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource?.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        await repository?.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource?.getRandomNumberTrivia());
        verify(mockLocalDataSource?.cacheNumberTrivia(tNumberTriviaModel));
      });
      test(
          'should return SERVER FAILURE when the call to remote data source is UNsuccessful',
          () async {
        //arrange
        when(mockRemoteDataSource?.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //act
        final result = await repository?.getRandomNumberTrivia();
        //assert
        verify(mockRemoteDataSource?.getRandomNumberTrivia());
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline( () {
      test('should returnnrandom number  ', () async {
        when(mockLocalDataSource?.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repository?.getRandomNumberTrivia();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource?.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test('should return cacheFailure when there is no cached data present.',
          () async {
        when(mockLocalDataSource?.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repository?.getRandomNumberTrivia();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource?.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
} 
