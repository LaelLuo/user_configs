import 'package:user_configs/user_configs.dart';

void main() {
  var configs = UserConfigs('test');
  print('awesome: ${configs.get('isAwesome')}');
}
