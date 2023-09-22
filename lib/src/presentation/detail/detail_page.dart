import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/presentation/utils/reusable_widget/custom_text.dart';
import 'package:starwars_app/src/application/prov_people_detail.dart';
import 'package:starwars_app/src/presentation/detail/components/homeworld.dart';
import 'package:starwars_app/src/presentation/detail/components/info_field.dart';
import 'package:starwars_app/src/presentation/detail/components/startships.dart';
import 'package:starwars_app/src/presentation/detail/components/vehicle.dart';

class PeopleDetailPage extends ConsumerStatefulWidget {
  final String detailUrl;

  const PeopleDetailPage({Key? key, required this.detailUrl}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PeopleDetailPageState();
}

class _PeopleDetailPageState extends ConsumerState<PeopleDetailPage> {
  @override
  void initState() {
    super.initState();
    ref.read(provPeopleDetail.notifier).peopleDetail(widget.detailUrl);
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(provPeopleDetail);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Star Wars',
          style: TextStyle(fontFamily: 'Starjedi'),
        ),
      ),
      backgroundColor: Colors.black,
      body: watch.when(
        data: (data) => ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/war.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText().starjediWhite(txt: watch.value?.name ?? '', size: 20),
                      const SizedBox(height: 20),
                      DetailInfoField(title: 'Gender', value: data.gender ?? ''),
                      const SizedBox(height: 20),
                      const StartshipsExpansion(), ///_____ Display startship information
                      const SizedBox(height: 20),
                      const VehicleExpansion(), ///_____ Display vehicle information
                      const SizedBox(height: 20),
                      const HomeworldExpansion(), ///_____ Display homeworld information
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        error: (error, stack) {
          return Container();
        },
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/gif/loading_3.gif', height: 130),
              const SizedBox(height: 20),
              CustomText().starjediWhite(txt: 'Loading ...')
            ],
          ),
        ),
      ),
    );
  }
}
