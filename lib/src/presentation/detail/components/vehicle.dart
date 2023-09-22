import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/presentation/utils/reusable_widget/custom_text.dart';
import 'package:starwars_app/src/application/prov_people_detail.dart';
import 'package:starwars_app/src/application/prov_vehicle.dart';
import 'package:starwars_app/src/presentation/detail/components/info_field.dart';
import 'package:starwars_app/src/presentation/home/components/home_refresh_loading.dart';

class VehicleExpansion extends ConsumerWidget {
  const VehicleExpansion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(provPeopleDetail);
    final watchVehicle = ref.watch(vehicleProvider);
    
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      iconColor: Colors.blue,
      collapsedIconColor: Colors.blue,
      title: CustomText().starjediWhite(txt: 'vehicle'),
      subtitle: CustomText().starjediWhite(txt: watch.value?.vehicles!.isNotEmpty == true ? '${watch.value?.vehicles?.length.toString()}' : '-'),
      children: (() {
        if (watch.value?.vehicles != null) {
          return List.generate(
            watch.value?.vehicles?.length ?? 0,
            (index) {
              ///______ Identify unique Startship data with 'id' that extracted from Url String 
              final getIdFromUrlString = watch.value?.vehicles?[index].replaceAll(RegExp(r'[^0-9]'), '');

              return ExpansionTile(
                title: CustomText().starjediWhite(txt: 'id - $getIdFromUrlString'),
                backgroundColor: Colors.transparent,
                collapsedIconColor: Colors.blue,
                childrenPadding: const EdgeInsets.only(left: 20),
                tilePadding: const EdgeInsets.only(left: 20),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                iconColor: Colors.blue,
                onExpansionChanged: (value) {
                  ///_____ Only request when current Startship data does not defined yet on [vehicleMap] Map data
                  if (value == true && watchVehicle.value?[getIdFromUrlString] == null) {
                    ref.read(vehicleProvider.notifier).getVehicle(getIdFromUrlString!, watch.value!.vehicles![index]);
                  }
                },
                children: [
                  if (watchVehicle.value?[getIdFromUrlString] != null) ...[
                    Column(
                      children: [
                        DetailInfoField(
                          title: 'Name',
                          value: watchVehicle.value?[getIdFromUrlString]?.name ?? '-',
                        ),
                        const SizedBox(height: 10),
                        DetailInfoField(
                          title: 'Model',
                          value: watchVehicle.value?[getIdFromUrlString]?.cargoCapacity ?? '-',
                        ),
                        const SizedBox(height: 10),
                        DetailInfoField(
                          title: 'Cost in credits',
                          value: watchVehicle.value?[getIdFromUrlString]?.costInCredits ?? '-',
                        ),
                      ],
                    )
                  ] else if (watchVehicle.value?[getIdFromUrlString] == null) ...[
                    const HomePageRefreshLoading()
                  ]
                ],
              );
            },
          );
        }
        return <Widget>[];
      }()),
    );
  }
}
