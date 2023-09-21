import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/data/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_startship.dart';

final startshipProvider = StateNotifierProvider<StartshipNotifier, AsyncValue<Map<String, ModelStartship>>>((ref) {
  return StartshipNotifier(ref);
});

/// Mark every vehicle remote-data results with custom [id] that extracted from UrlString
/// wrap it with [ <String, ModelStartship>{} ] scheme, then defined it on [starshipMap] Map
/// It will remain until User close the app, so a single Starship data will get for one-time only 
/// and can be reuse for another people/character as long the id is same
class StartshipNotifier extends StateNotifier<AsyncValue<Map<String, ModelStartship>>> {
  StartshipNotifier(this._notifierProviderRef) : super(const AsyncValue.data({})) {
    _dataSource = _notifierProviderRef.watch(starWarsDataSrcProvider);
  }
  final StateNotifierProviderRef _notifierProviderRef;
  late final StarWarsDataSource _dataSource;
  final starshipMap = <String, ModelStartship>{};

  Future<void> getStartship(String idx, String url) async {
    final res = await AsyncValue.guard(() async => await _dataSource.startship(url));
    final modelStartship = ModelStartship.fromJson(res.value);
    final stringModel = <String, ModelStartship>{idx : modelStartship};
    starshipMap.addEntries(stringModel.entries);
    state = AsyncValue.data(starshipMap);
  }
}
