import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tddapp/feature/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:tddapp/feature/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

@GenerateMocks([
  HttpClient
], customMocks: [
  MockSpec<HttpClient>(
      as: #MockHttpClientForTest, returnNullOnMissingStub: true),
])
void main() {
  NumberTriviaRemoteDataSourceImpl? dataSource;
  MockHttpClient mockHttpClient = MockHttpClient();

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(int number) async {
    final url = Uri.parse('http://numbersapi.com/$number');
    when(mockHttpClient.get(url))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200(tNumber);
        // act
        dataSource?.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockHttpClient.get(
          Uri.parse('http://numbersapi.com/$tNumber'),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );
  });
}
