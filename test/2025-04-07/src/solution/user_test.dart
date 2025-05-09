import 'package:modu_3_dart_study/assignments/2025-04-07/src/solution/core/result.dart';
import 'package:modu_3_dart_study/assignments/2025-04-07/src/solution/data_source/mock_auth_remote_data_source_impl.dart';
import 'package:modu_3_dart_study/assignments/2025-04-07/src/solution/enum/registration_error.dart';
import 'package:modu_3_dart_study/assignments/2025-04-07/src/solution/model/user.dart';
import 'package:modu_3_dart_study/assignments/2025-04-07/src/solution/repository/auth_repository.dart';
import 'package:modu_3_dart_study/assignments/2025-04-07/src/solution/repository/auth_repository_impl.dart';
import 'package:test/test.dart';

void main() {
  String testEmail = '';
  String testPassword = '';

  // final List<Map<String, dynamic>> users = [];

  // final mockClient = MockClient((request) async {
  //   if (request.method == 'POST' && request.url.path == '/register') {
  //     final body = jsonDecode(request.body);

  //     final email = body['email'] as String?;
  //     final password = body['password'] as String?;

  //     if (email != null && password != null) {
  //       users.add({'email': email, 'password': password});

  //       return http.Response(
  //         jsonEncode({'message': 'User added', 'userCount': users.length}),
  //         200,
  //         headers: {'content-type': 'application/json; charset=utf-8'},
  //       );
  //     } else {
  //       return http.Response('Bad Request', 400);
  //     }
  //   }

  //   // 다른 요청
  //   return http.Response('Network Error', 500);
  // });

  group('Auth Repository Test', () {
    final AuthRepository repository = AuthRepositoryImpl(
      authRemoteDataSource: MockAuthRemoteDataSourceImpl(),
    );
    test('User 생성 성공', () async {
      testEmail = 'test@example.com';
      testPassword = '12345678';

      final result = await repository.registerUser(
        email: testEmail,
        password: testPassword,
      );

      switch (result) {
        case Success<User, RegistrationError>():
          expect(result.value, isA<User>());
          expect(result.value.id, 'abcd1234');
          expect(result.value.email, testEmail);
          expect(result.value.password, testPassword);

        case Failure<User, RegistrationError>():
          fail('사용자 등록이 실패했습니다: ${result.error}');
      }
    });

    test('User 생성 실패 - 유효하지 않은 이메일', () async {
      testEmail = 'testexample.com';
      testPassword = '12345678';

      final result = await repository.registerUser(
        email: testEmail,
        password: testPassword,
      );

      expect(
        result,
        Result<User, RegistrationError>.failure(RegistrationError.invalidEmail),
      );
    });

    test('User 생성 실패 - 비밀번호가 6자리 이하', () async {
      testEmail = 'test@example.com';
      testPassword = '12345'; // 비밀번호 5자리

      final result = await repository.registerUser(
        email: testEmail,
        password: testPassword,
      );

      expect(
        result,
        Result<User, RegistrationError>.failure(RegistrationError.weakPassword),
      );
    });

    test('User 생성 실패 - 네트워크 오류', () async {
      final repository = AuthRepositoryImpl(
        authRemoteDataSource: MockAuthRemoteDataSourceImpl(),
      );

      testEmail = 'test1@example.com';
      testPassword = '12345678'; // 비밀번호 5자리

      final result = await repository.registerUser(
        email: testEmail,
        password: testPassword,
      );

      expect(
        result,
        Result<User, RegistrationError>.failure(RegistrationError.networkError),
      );
    });
  });
}
