import 'package:user_configs/user_configs.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final configs = UserConfigs('user_configs.test');

    setUp(() async {
      await configs.init();
    });

    test('First Test', () {
      expect(configs.getBoolean('test'), isTrue);
    });
  });
}
