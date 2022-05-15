import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tddapp/core/platform/network_info.dart';


class MockDataConnectionChecker extends Mock implements DataConnectionChecker{}
void main() {
  late NetworkInfoImpl? networkInfoImpl;
  late MockDataConnectionChecker? mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker!);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection',
        () async {
      //arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockDataConnectionChecker?.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      //act
      final result = networkInfoImpl?.isConnected;
      //assert
      verify(mockDataConnectionChecker?.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
