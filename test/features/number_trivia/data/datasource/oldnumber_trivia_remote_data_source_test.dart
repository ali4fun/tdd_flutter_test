
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';



void main() {
//   NumberTriviaRemoteDataSourceImpl? dataSource;

//   setUp(() {
//     // dataSource = NumberTriviaRemoteDataSourceImpl(client: MockClient);
//   });

//   void setUpMockHttpClientSuccess200(int number) async {
//     final url = Uri.parse('http://numbersapi.com/$number');
    


//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async =>
//              http.Response(fixture('trivia.json'), 200));

//   }

//   Future<NumberTrivia> fetchAlbum(http.Client client) async {
//   final response = await client
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return  NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

//   group('getConcreteNumberTrivia', () {
//     final tNumber = 1;
//     final tNumberTriviaModel =
//         NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

// test('returns an Album if the http call completes successfully', () async {
     
//      final client = MockClient();


//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async =>
//              http.Response(fixture('trivia.json'), 200));


//       expect(client, 'isA<Album>()');
//     });

//     // test(
//     //   '''should perform a GET request on a URL with number
//     //    being the endpoint and with application/json header''',
//     //   () async {
//     //     // arrange
//     //     // setUpMockHttpClientSuccess200(tNumber);
//     //     const tUsername = 'username';
//     //     final url = Uri.parse('https://api.test.com/query?username=$tUsername');

//     //       // final client = MockClient((_) async =>
//     //       // http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));
//     //     when(mockHttpClient.get(url))
//     //     .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
//     //     // act
//     //     dataSource?.getConcreteNumberTrivia(tNumber);
//     //     // assert
//     //     verify(mockHttpClient.get(
//     //       Uri.parse('http://numbersapi.com/$tNumber'),
//     //       headers: {
//     //         'Content-Type': 'application/json',
//     //       },
//     //     ));
//     //   },
//     // );

//   });
}
