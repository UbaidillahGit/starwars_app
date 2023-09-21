import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/data/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_vehicle.dart';

final vehicleProvider = StateNotifierProvider<VehicleNotifier, AsyncValue<Map<String, ModelVehicle>>>((ref) {
  return VehicleNotifier(ref);
});

/// Mark every vehicle remote-data results with own-custom [id] that extracted from UrlString
/// wrap it with [ <String, ModelVehicle>{} ] scheme, then defined it on [vehicleMap] Map.
/// It will remain until User close the app, so a single vehicle data will get for one-time only 
/// and can be reuse for another people/character as long the id is same
class VehicleNotifier extends StateNotifier<AsyncValue<Map<String, ModelVehicle>>> {
  VehicleNotifier(this._notifierProviderRef) : super(const AsyncValue.data(<String, ModelVehicle>{})) {
    _dataSource = _notifierProviderRef.watch(starWarsDataSrcProvider);
  }

  final StateNotifierProviderRef _notifierProviderRef;
  late final StarWarsDataSource _dataSource;
  final vehicleMap = <String, ModelVehicle>{};

  Future<void> getVehicle(String id, String url) async {
    final res = await AsyncValue.guard(() async => await _dataSource.startship(url));
    final modelVehicle = ModelVehicle.fromJson(res.value);
    final stringModel = <String, ModelVehicle>{id : modelVehicle};
    vehicleMap.addEntries(stringModel.entries);
    state = AsyncValue.data(vehicleMap);
  }
}
