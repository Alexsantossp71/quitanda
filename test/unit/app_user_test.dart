import 'package:flutter_test/flutter_test.dart';
import 'package:greengrocery/src/models/user_model.dart';

void main() {
  group('UserModel', () {
    late UserModel user;

    setUp(() {
      user = UserModel(
        id: 'test-id',
        email: 'test@email.com',
        name: 'João da Silva',
        phone: '11 99999-1234',
        cpf: '123.456.789-00',
        password: 'senha123',
        token: 'test-token',
      );
    });

    test('cria UserModel com dados corretos', () {
      expect(user.id, 'test-id');
      expect(user.email, 'test@email.com');
      expect(user.name, 'João da Silva');
      expect(user.phone, '11 99999-1234');
      expect(user.cpf, '123.456.789-00');
      expect(user.password, 'senha123');
      expect(user.token, 'test-token');
    });

    test('serializa para JSON com chave fullname', () {
      final json = user.toJson();
      expect(json['id'], 'test-id');
      expect(json['email'], 'test@email.com');
      // name é serializado como 'fullname' no JSON
      expect(json['fullname'], 'João da Silva');
      expect(json['phone'], '11 99999-1234');
    });

    test('desserializa de JSON com chave fullname', () {
      final json = user.toJson();
      final restored = UserModel.fromJson(json);
      expect(restored.id, user.id);
      expect(restored.email, user.email);
      expect(restored.name, 'João da Silva');
    });

    test('toString contém dados relevantes', () {
      final str = user.toString();
      expect(str.contains('João da Silva'), true);
      expect(str.contains('test@email.com'), true);
    });

    test('serialização round-trip preserva dados', () {
      final json = user.toJson();
      final restored = UserModel.fromJson(json);
      expect(restored.toJson(), json);
    });
  });
}
