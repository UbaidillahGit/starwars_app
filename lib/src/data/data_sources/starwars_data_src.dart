import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:starwars_app/src/data/data_sources/err_handler_mode.dart';
import 'package:starwars_app/src/data/model/model_people.dart';
import 'package:starwars_app/src/data/model/model_people_detail.dart';
import 'package:starwars_app/src/data/model/model_species.dart';
import 'package:starwars_app/src/data/model/model_species_detail.dart';

final starWarsDataSrcProvider = Provider((ref) => StarWarsDataSource());

///____ Define all SWAPI remote data API 
class StarWarsDataSource {

  Future<ModelSpecies> speciesList() async {
    try {
      final url = Uri.parse('https://swapi.dev/api/species/');
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelSpecies.fromJson(convert);
      
      return object;
    } catch (e) {
      if (kDebugMode) {
        print('speciesList Catch $e');
      }
      return ModelSpecies();
    }
  }

  Future<ModelPeople> getPeople() async {
    try {
      final url = Uri.parse('https://swapi.dev/api/people/');
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelPeople.fromJson(convert);

      return object;
    } catch (e) {
      log('getPeople Catch $e');
      return ModelPeople();
    }
  }

  Future<ModelPeople> peoplePagination(String nextUrl) async {
    try {
      final url = Uri.parse(nextUrl);
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelPeople.fromJson(convert);
      
      return object;
    } catch (e) {
      if (kDebugMode) {
        print('speciesPagination Catch $e');
      }
      return ModelPeople();
    }
  }

  Future<ModelPeople> searchPeople(String keyword) async {
    try {
      final url = Uri.parse('https://swapi.dev/api/people/?search=$keyword');
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelPeople.fromJson(convert);

      return object;
    } catch (e) {
      log('getPeople Catch $e');
      return ModelPeople();
    }
  }

  Future<ModelSpecies> speciesPagination(String nextUrl) async {
    try {
      final url = Uri.parse(nextUrl);
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelSpecies.fromJson(convert);
      
      return object;
    } catch (e) {
      if (kDebugMode) {
        print('speciesPagination Catch $e');
      }
      return ModelSpecies();
    }
  }

  Future<ModelSpeciesDetail> speciesDetail(String detailUrl) async {
    try {
      final url = Uri.parse(detailUrl);
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelSpeciesDetail.fromJson(convert);
      
      return object;
    } catch (e) {
      if (kDebugMode) {
        print('speciesPagination Catch $e');
      }
      return ModelSpeciesDetail();
    }
  }

  Future<ModelPeopleDetail> peopleDetail(String detailUrl) async {
    try {
      final url = Uri.parse(detailUrl);
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelPeopleDetail.fromJson(convert);
      
      return object;
    } catch (e) {
      if (kDebugMode) {
        print('speciesPagination Catch $e');
      }
      return ModelPeopleDetail();
    }
  }

  Future<dynamic> startship(String detailUrl) async {
    try {
      final url = Uri.parse(detailUrl);
      final response = await http.get(url);
      return json.decode(response.body);
    } catch (e) {
      return RemoteDataErrHandle(errType: 'startship catch', errMessage: e);
    }
  }

  Future<dynamic> vehicle(String detailUrl) async {
    try {
      final url = Uri.parse(detailUrl);
      final response = await http.get(url);
      return json.decode(response.body);
    } catch (e) {
      return RemoteDataErrHandle(errType: 'vehicle catch', errMessage: e);
    }
  }

  Future<dynamic> homeworld(String stringlUrl) async {
    try {
      final url = Uri.parse(stringlUrl);
      final response = await http.get(url);
      return json.decode(response.body);
    } catch (e) {
      return RemoteDataErrHandle(errType: 'homeworld catch', errMessage: e);
    }
  }
}