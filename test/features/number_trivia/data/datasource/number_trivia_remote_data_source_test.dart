import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tddapp/core/error/exceptions.dart';
import 'package:tddapp/feature/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:tddapp/feature/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([
  http.Client
], customMocks: [
  MockSpec<http.Client>(as: #MockClientForTest, returnNullOnMissingStub: false),
])
void main() {
  NumberTriviaRemoteDataSourceImpl? dataSource;
  MockClient? mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockClient!);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockClient?.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient?.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number
       being the endpoint and with application/json header''', () async {
      // final client = MockClient();
     setUpMockHttpClientSuccess200();

      dataSource?.getConcreteNumberTrivia(tNumber);
      // assert

      verify(mockClient?.get(Uri.parse('http://numbersapi.com/$tNumber')));
    });
    
    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource?.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource?.getConcreteNumberTrivia;
        // assert
        expect(() => call!(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource?.getRandomNumberTrivia();
        // assert
        verify(mockClient?.get(
          Uri.parse('http://numbersapi.com/random')
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource?.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource?.getRandomNumberTrivia;
        // assert
        expect(() => call!(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
