class ModelVehicle {
  String? name;
  String? model;
  String? manufacturer;
  String? costInCredits;
  String? length;
  String? maxAtmospheringSpeed;
  String? crew;
  String? passengers;
  String? cargoCapacity;
  String? consumables;
  String? vehicleClass;
  List<String>? pilots;
  List<String>? films;
  String? created;
  String? edited;
  String? url;

  ModelVehicle(
      {this.name,
      this.model,
      this.manufacturer,
      this.costInCredits,
      this.length,
      this.maxAtmospheringSpeed,
      this.crew,
      this.passengers,
      this.cargoCapacity,
      this.consumables,
      this.vehicleClass,
      this.pilots,
      this.films,
      this.created,
      this.edited,
      this.url});

  ModelVehicle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    model = json['model'];
    manufacturer = json['manufacturer'];
    costInCredits = json['cost_in_credits'];
    length = json['length'];
    maxAtmospheringSpeed = json['max_atmosphering_speed'];
    crew = json['crew'];
    passengers = json['passengers'];
    cargoCapacity = json['cargo_capacity'];
    consumables = json['consumables'];
    vehicleClass = json['vehicle_class'];
    pilots = json['pilots'].cast<String>();
    films = json['films'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['model'] = model;
    data['manufacturer'] = manufacturer;
    data['cost_in_credits'] = costInCredits;
    data['length'] = length;
    data['max_atmosphering_speed'] = maxAtmospheringSpeed;
    data['crew'] = crew;
    data['passengers'] = passengers;
    data['cargo_capacity'] = cargoCapacity;
    data['consumables'] = consumables;
    data['vehicle_class'] = vehicleClass;
    data['pilots'] = pilots;
    data['films'] = films;
    data['created'] = created;
    data['edited'] = edited;
    data['url'] = url;
    return data;
  }
}
