import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/infrastructure/data_sources/starwars_data_src.dart';
import 'package:starwars_app/src/data/model/model_people.dart';

///_____ define bool value provider for loading indicator mechanism
final isLoadingPagination = StateProvider.autoDispose<bool>((ref) => false);

final peopleProvider = StateNotifierProvider<PeopleNotifier, AsyncValue<ModelPeople>>((ref) => PeopleNotifier(ref));

class PeopleNotifier extends StateNotifier<AsyncValue<ModelPeople>> {
  PeopleNotifier(this._notifierProviderRef) : super(AsyncValue.data(ModelPeople())) {
    _dataSource = _notifierProviderRef.watch(starWarsDataSrcProvider);
  }

  late final StarWarsDataSource _dataSource;
  final StateNotifierProviderRef _notifierProviderRef;
  bool isLoadingPagination = false;

  ///_____ Get all Starwars character by people
  Future<void> getPoeple() async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(() async => await _dataSource.getPeople());
    state = AsyncValue.data(res.asData!.value);
  }

  ///_____ Get another next pagination data
  Future<void> paginationNext() async {
    final String? nextUrl = state.value?.next;

    ///_____ Update the state so isLoadingPagination can be updated on widget
    isLoadingPagination = true;
    state = AsyncValue.data(state.asData!.value);

    ///_____ Check nextUrl available, if null then no pagination will run
    if (nextUrl != null) {
      final res = await AsyncValue.guard(() async => await _dataSource.peoplePagination(nextUrl));

      if (res.value != null && state.value!.results != null) {
        state.value?.next = res.value?.next;
        for (var i = 0; i < res.value!.results!.length; i++) {
          state.value?.results!.add(res.value!.results![i]);
        }
      }
    }
    state = AsyncValue.data(state.asData!.value);
    isLoadingPagination = false;
  }
}
