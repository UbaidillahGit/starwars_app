import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starwars_app/src/application/prov_people.dart';
import 'package:starwars_app/src/application/prov_scroll_notifier.dart';
import 'package:starwars_app/src/presentation/detail/detail_page.dart';

class LayoutGridview extends ConsumerWidget {
  const LayoutGridview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchPeople = ref.watch(peopleProvider); ///_____ Watch for people/character remote data

    return GridView.builder(
      controller: ref.watch(scrollProvider.notifier).scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => PeopleDetailPage(detailUrl: watchPeople.value?.results?[index].url ?? ''))),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
                  image: AssetImage('assets/images/eclipse.jpeg'),
                  opacity: 100,
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                  child: Center(
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          '${watchPeople.value?.results?[index].name}',
                          style: const TextStyle(fontFamily: 'Starjedi', color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ),
              ),
            ),
          ),
        );
      },
      itemCount: watchPeople.value?.results?.length,
    );
  }
}