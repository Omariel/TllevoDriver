part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnowLocation;
  final List<LatLng> myLocationHisotory;

  const LocationState(
      {this.followingUser = false, this.lastKnowLocation, myLocationHisotory})
      : myLocationHisotory = myLocationHisotory ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnowLocation,
    List<LatLng>? myLocationHisotory,
  }) =>
      LocationState(
          followingUser: followingUser ?? this.followingUser,
          lastKnowLocation: lastKnowLocation ?? this.lastKnowLocation,
          myLocationHisotory: myLocationHisotory ?? this.myLocationHisotory);

  @override
  List<Object?> get props =>
      [followingUser, lastKnowLocation, myLocationHisotory];
}
