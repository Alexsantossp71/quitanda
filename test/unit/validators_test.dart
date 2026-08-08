import 'package:flutter_test/flutter_test.dart';
import 'package:greengrocery/src/services/validators.dart';

void main() {
  group('emailValidator', () {
    test('retorna null para e-mail valido', () {
      expect(emailValidator('user@example.com'), isNull);
    });

    test('retorna null para e-mail com subdominio', () {
      expect(emailValidator('user@mail.example.com'), isNull);
    });

    test('retorna erro para null', () {
      expect(emailValidator(null), isNotNull);
      expect(emailValidator(null), equals('Digite seu e-mail'));
    });

    test('retorna erro para string vazia', () {
      expect(emailValidator(''), isNotNull);
      expect(emailValidator(''), equals('Digite seu e-mail'));
    });

    test('retorna erro para e-mail sem @', () {
      expect(emailValidator('userexample.com'), isNotNull);
    });

    test('retorna erro para e-mail sem dominio', () {
      expect(emailValidator('user@'), isNotNull);
    });

    test('retorna erro para e-mail sem usuario', () {
      expect(emailValidator('@example.com'), isNotNull);
    });
  });

  group('passwordValidator', () {
    test('retorna null para senha com 7+ caracteres', () {
      expect(passwordValidator('1234567'), isNull);
      expect(passwordValidator('minhasenha'), isNull);
    });

    test('retorna null para senha longa', () {
      expect(passwordValidator('uma_senha_muito_segura_123'), isNull);
    });

    test('retorna erro para null', () {
      expect(passwordValidator(null), isNotNull);
      expect(passwordValidator(null), equals('Digite sua senha'));
    });

    test('retorna erro para string vazia', () {
      expect(passwordValidator(''), isNotNull);
      expect(passwordValidator(''), equals('Digite sua senha'));
    });

    test('retorna erro para senha com menos de 7 caracteres', () {
      expect(passwordValidator('123456'), isNotNull);
      expect(passwordValidator('123456'), equals('Digite uma senha com pelo menos 7 caracteres'));
    });

    test('retorna erro para senha com 1 caractere', () {
      expect(passwordValidator('a'), isNotNull);
    });

    test('retorna erro para senha com 6 caracteres', () {
      expect(passwordValidator('abcdef'), isNotNull);
    });
  });

  group('nameValidator', () {
    test('retorna null para nome completo', () {
      expect(nameValidator('Joao Silva'), isNull);
      expect(nameValidator('Maria Joana'), isNull);
    });

    test('retorna null para nome com mais de 2 partes', () {
      expect(nameValidator('Joao Pedro da Silva'), isNull);
    });

    test('retorna erro para null', () {
      expect(nameValidator(null), isNotNull);
      expect(nameValidator(null), equals('Digite seu Nome Completo'));
    });

    test('retorna erro para string vazia', () {
      expect(nameValidator(''), isNotNull);
      expect(nameValidator(''), equals('Digite seu Nome Completo'));
    });

    test('retorna erro para somente primeiro nome', () {
      expect(nameValidator('Joao'), isNotNull);
      expect(nameValidator('Joao'), equals('Digite seu nome completo'));
    });

    test('retorna null para nome com espaco no final', () {
      // split(' ') com espaco extra cria elemento vazio
      expect(nameValidator('Joao Silva '), isNull);
    });
  });
}
