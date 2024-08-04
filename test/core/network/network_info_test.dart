import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search_zipcode/core/network/network_info_impl.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(connectivity: mockConnectivity);
  });

  test('should return true when connected to wifi', () async {
    // arrange
    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.wifi);
    // act
    final result = await networkInfo.isConnected;
    // assert
    expect(result, true);
  });

  test('should return false when not connected to any network', () async {
    // arrange
    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.none);
    // act
    final result = await networkInfo.isConnected;
    // assert
    expect(result, false);
  });
}
