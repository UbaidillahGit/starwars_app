import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/data/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_vehicle.dart';

final vehicleProvider = StateNotifierProvider<VehicleNotifier, AsyncValue<Map<String, ModelVehicle>>>((ref) {
  return VehicleNotifier(ref);
});

class VehicleNotifier extends StateNotifier<AsyncValue<Map<String, ModelVehicle>>> {
  VehicleNotifier(this._notifierProviderRef) : super(const AsyncValue.data(<String, ModelVehicle>{})) {
    _dataSource = _notifierProviderRef.watch(starWarsDataSrcProvider);
  }

  final StateNotifierProviderRef _notifierProviderRef;
  late final StarWarsDataSource _dataSource;
  final vehicleMap = <String, ModelVehicle>{};

  Future<void> getVehicle(String idx, String url) async {
    final res = await AsyncValue.guard(() async => await _dataSource.startship(url));
    final modelVehicle = ModelVehicle.fromJson(res.value);
    final stringModel = <String, ModelVehicle>{idx : modelVehicle};
    vehicleMap.addEntries(stringModel.entries);
    state = AsyncValue.data(vehicleMap);
    // log('getVehicle $idx | ${state.value?.entries.toList()}');
  }
}
