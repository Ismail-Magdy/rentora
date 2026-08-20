import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentora/core/helpers/extensions.dart';
import 'package:rentora/core/routing/routes.dart';
import 'package:rentora/core/themes/app_colors.dart';
import 'package:rentora/core/widgets/custom_feedback_dialog.dart';
import 'package:rentora/features/setup_profile/manager/location/location_cubit.dart';
import 'package:rentora/features/setup_profile/presentation/widgets/location_floating_address_card.dart';
import 'package:rentora/features/setup_profile/presentation/widgets/location_bottom_sheet.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  // Default center ( Cairo ) until GPS fetches the real one
  final LatLng _initialCenter = const LatLng(30.0444, 31.2357);

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationError) {
            // Show error using CustomFeedbackDialog
            showFeedbackDialog(
              context,
              icon: Icons.error_outline,
              color: AppColors.error,
              title: "Error",
              message: state.error,
            );
            //
          } else if (state is LocationSavedSuccess) {
            // Move to the Interests Screen
            showFeedbackDialog(
              context,
              icon: Icons.check_circle_outline,
              color: Colors.green,
              title: "Success",
              message: "location has been saved",
              onFinish: () =>
                  context.pushReplacementNamed(Routes.interestsScreen),
            );
          } else if (state is LocationSelected) {
            // Move the map to the selected GPS location
            _mapController.move(LatLng(state.latitude, state.longitude), 15.0);
          }
        },
        builder: (context, state) {
          final cubit = context.read<LocationCubit>();

          return Stack(
            children: [
              /// The OpenStreetMap Layer
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _initialCenter,
                  initialZoom: 15.0,
                  // Listen to map drag events to update the address when the user stops dragging
                  onMapEvent: (MapEvent mapEvent) {
                    if (mapEvent is MapEventMoveEnd) {
                      final center = _mapController.camera.center;
                      cubit.updateMarkerPosition(
                        center.latitude,
                        center.longitude,
                      );
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.rentora',
                  ),
                ],
              ),
              //
              /// The Fixed Center Marker (Pin)
              const Center(
                child: Padding(
                  padding: .only(bottom: 40.0),
                  child: Icon(
                    Icons.location_on,
                    color: AppColors.primaryColor,
                    size: 50.0,
                  ),
                ),
              ),
              //
              /// Top Floating Address Card
              LocationFloatingAddressCard(
                state: state,
                cubitSelectedAddress: cubit.selectedAddress,
              ),
              //
              /// Bottom Sheet Container
              LocationBottomSheet(
                state: state,
                searchController: _searchController,
                onTapCurrentLocation: () => cubit.getCurrentLocation(),
                onPressedSaveLocation: () => cubit.saveLocation(),
              ),
              //
            ],
          );
        },
      ),
    );
  }
}
// 315