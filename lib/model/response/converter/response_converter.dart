import 'package:japx/japx.dart';

Map<String, dynamic> mapDataJson(Map<String, dynamic> json) =>
    Japx.decode(json)['data'];

Map<String, dynamic> mapRootJson(Map<String, dynamic> json) {
  return Japx.decode(json);
}
