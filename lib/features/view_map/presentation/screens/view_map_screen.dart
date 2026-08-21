import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentora/core/helpers/spacing.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_app_bar.dart';
import 'package:rentora/core/widgets/error_screen.dart';
import 'package:rentora/features/view_map/manager/view_map_cubit.dart';
import 'package:rentora/features/view_map/manager/view_map_state.dart';
import 'package:rentora/features/view_map/presentation/widgets/animated_item_marker.dart';
import 'package:rentora/features/view_map/presentation/widgets/user_location_marker.dart';

class ViewMapScreen extends StatefulWidget {
  const ViewMapScreen({super.key});

  @override
  State<ViewMapScreen> createState() => _ViewMapScreenState();
}

class _ViewMapScreenState extends State<ViewMapScreen> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    context.read<ViewMapCubit>().getViewMapData();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Widget _buildSkeletonMap() {
    return Skeletonizer(
      enabled: true,
      child: Stack(
        children: [
          Container(color: Colors.grey[200]),
          Positioned(
            top: 200,
            left: 100,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 400,
            right: 80,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 300,
            left: 150,
            child: Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        text: "Map View",
        actions: [
          GestureDetector(
            onTap: () {
              final state = context.read<ViewMapCubit>().state;
              if (state is ViewMapLoaded) {
                final userLocation = LatLng(
                  state.userLatitude,
                  state.userLongitude,
                );
                _mapController.move(userLocation, 14.0);
              }
            },
            child: Icon(
              Icons.my_location_rounded,
              color: AppColors.primaryColor,
            ),
          ),
          horizontalSpace(10),
        ],
      ),
      body: BlocBuilder<ViewMapCubit, ViewMapState>(
        builder: (context, state) {
          if (state is ViewMapLoading || state is ViewMapInitial) {
            return _buildSkeletonMap();
          }

          if (state is ViewMapError) {
            return const ErrorScreen();
          }

          if (state is ViewMapLoaded) {
            final userLocation = LatLng(
              state.userLatitude,
              state.userLongitude,
            );

            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: userLocation,
                initialZoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.rentora',
                ),
                MarkerLayer(
                  markers: [
                    // Item Markers
                    ...state.products.map((item) {
                      return Marker(
                        point: LatLng(item.latitude!, item.longitude!),
                        width: 60,
                        height: 60,
                        alignment: Alignment.topCenter,
                        child: AnimatedItemMarker(
                          imageUrl: item.imageUrl,
                          onTap: () => context.pushNamed(
                            Routes.itemDetailsScreen,
                            arguments: item.id,
                          ),
                        ),
                      );
                    }),
                    // User Location Marker
                    Marker(
                      point: userLocation,
                      width: 100,
                      height: 80,
                      alignment: Alignment.topCenter,
                      child: UserLocationMarker(firstName: state.userFirstName),
                    ),
                  ],
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
