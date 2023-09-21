import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/data/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_homworld.dart';

final homeworldProvider = StateNotifierProvider<HomeworldNotifier, AsyncValue<Map<String, ModelHomeworld>>>((ref) {
  return HomeworldNotifier(ref);
});

/// Mark every vehicle remote-data results with custom [id] that extracted from UrlString
/// wrap it with [ <String, ModelHomeworld>{} ] scheme, then defined it on [homeworldMap] Map
/// It will remain until User close the app, so a single Homeworld data will get for one-time only 
/// and can be reuse for another people/character as long the id is same
class HomeworldNotifier extends StateNotifier<AsyncValue<Map<String, ModelHomeworld>>> {
  HomeworldNotifier(this._notifierProviderRef) : super(const AsyncValue.data({})) {
    _dataSource = _notifierProviderRef.watch(starWarsDataSrcProvider);
  }
  final StateNotifierProviderRef _notifierProviderRef;
  late final StarWarsDataSource _dataSource;
  final homeworldMap = <String, ModelHomeworld>{};

  Future<void> getHomeworld(String idx, String url) async {
    final res = await AsyncValue.guard(() async => await _dataSource.homeworld(url));
    final modelHomeworld = ModelHomeworld.fromJson(res.value);
    final stringModel = <String, ModelHomeworld>{idx : modelHomeworld};
    homeworldMap.addEntries(stringModel.entries);
    state = AsyncValue.data(homeworldMap);
  }
}
