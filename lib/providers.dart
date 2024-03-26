import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:checklist_app/provider/auth.dart';
import 'package:checklist_app/provider/note.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => AuthNotifier()),
  ChangeNotifierProvider(create: (_) => NoteNotifier()),
];