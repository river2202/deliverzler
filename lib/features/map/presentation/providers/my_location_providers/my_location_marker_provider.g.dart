// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_location_marker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myLocationMarkerHash() => r'f8911633731bd507b09142ae5b5a19d87cbeae4c';

/// See also [myLocationMarker].
@ProviderFor(myLocationMarker)
final myLocationMarkerProvider = AutoDisposeProvider<Option<Marker>>.internal(
  myLocationMarker,
  name: r'myLocationMarkerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myLocationMarkerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MyLocationMarkerRef = AutoDisposeProviderRef<Option<Marker>>;
String _$myLocationMarkerIconHash() =>
    r'2ba8d3e107de7aafbd3379de2da1ff2cc7efeb57';

/// See also [myLocationMarkerIcon].
@ProviderFor(myLocationMarkerIcon)
final myLocationMarkerIconProvider =
    AutoDisposeFutureProvider<BitmapDescriptor>.internal(
  myLocationMarkerIcon,
  name: r'myLocationMarkerIconProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myLocationMarkerIconHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MyLocationMarkerIconRef
    = AutoDisposeFutureProviderRef<BitmapDescriptor>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
