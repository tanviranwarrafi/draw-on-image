import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart' show SingleChildWidget;
import 'package:tutorial/features/drawing/drawing_view_model.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => DrawingViewModel()),
];
