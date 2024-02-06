import 'package:flutter/material.dart';

import 'src/app_widget.dart';
import 'src/get_it_injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(const AppWidget());
}
