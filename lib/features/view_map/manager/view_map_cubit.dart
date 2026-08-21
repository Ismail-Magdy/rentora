import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentora/features/home/data/repos/home_repo.dart';
import 'package:rentora/features/view_map/manager/view_map_state.dart';

class ViewMapCubit extends Cubit<ViewMapState> {
  final HomeRepo _homeRepo;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ViewMapCubit(this._homeRepo) : super(ViewMapInitial());

  Future<void> getViewMapData() async {
    emit(ViewMapLoading());

    try {
      // Fetch products
      final productsResult = await _homeRepo.getProducts();

      // Fetch user location
      final locationResult = await _homeRepo.getUserLocation();

      //  Fetch user first name
      String firstName = 'Me';
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userDoc = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (userDoc.exists) {
          final data = userDoc.data();
          firstName = data?['firstName'] ?? data?['name'] ?? 'Me';
        }
      }

      productsResult.fold((failure) => emit(ViewMapError(failure.message)), (
        products,
      ) {
        locationResult.fold((failure) => emit(ViewMapError(failure.message)), (
          locationData,
        ) {
          final userLat = locationData?.latitude ?? 0.0;
          final userLng = locationData?.longitude ?? 0.0;

          // Filter out current user's items and ensure items have valid coordinates
          final currentUserId = _auth.currentUser?.uid ?? '';
          final filteredProducts = products.where((item) {
            return item.ownerId != currentUserId &&
                item.latitude != null &&
                item.longitude != null;
          }).toList();

          emit(
            ViewMapLoaded(
              products: filteredProducts,
              userLatitude: userLat,
              userLongitude: userLng,
              userFirstName: firstName,
            ),
          );
        });
      });
    } catch (e) {
      emit(ViewMapError(e.toString()));
    }
  }
}



















// class ViewMapCubit extends Cubit<ViewMapState> {
//   final HomeRepo _homeRepo;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   ViewMapCubit(this._homeRepo) : super(ViewMapInitial());

//   Future<void> getViewMapData() async {
//     emit(ViewMapLoading());

//     try {
//       // Fetch products
//       final productsResult = await _homeRepo.getProducts();

//       // Fetch user location
//       final locationResult = await _homeRepo.getUserLocation();

//       // Fetch user first name
//       String firstName = 'Me';
//       final currentUser = _auth.currentUser;
//       if (currentUser != null) {
//         final userDoc = await _firestore
//             .collection('users')
//             .doc(currentUser.uid)
//             .get();
//         if (userDoc.exists) {
//           final data = userDoc.data();
//           firstName = data?['firstName'] ?? data?['name'] ?? 'Me';
//         }
//       }

//       productsResult.fold((failure) => emit(ViewMapError(failure.message)), (
//         products,
//       ) {
//         locationResult.fold((failure) => emit(ViewMapError(failure.message)), (
//           locationData,
//         ) {
//           final userLat = locationData?.latitude ?? 0.0;
//           final userLng = locationData?.longitude ?? 0.0;

//           // Filter out current user's items and ensure items have valid coordinates
//           final currentUserId = _auth.currentUser?.uid ?? '';
//           final filteredProducts = products.where((item) {
//             return item.ownerId != currentUserId &&
//                 item.latitude != null &&
//                 item.longitude != null;
//           }).toList();

//           // 🔴 ----- بداية الداتا الوهمية للتيست ----- 🔴
//           // ضفنا منتجات وهمية حوالين اللوكيشن بتاعك عشان تتيست الأنيميشن والماركرز
//           // (غير ProductModel لاسم الكلاس الحقيقي اللي عندك لو مختلف)

//           filteredProducts.addAll([
//             ProductModel(
//               id: 'fake_1',
//               name: 'PS4 Console',
//               category: 'gaming',
//               price: 250.0,
//               rating: 4.8,
//               distance: 1.2,
//               locationName: 'Fake',
//               ownerId: 'fake_user_1',
//               latitude: userLat + 0.005, // فوقك بشوية
//               longitude: userLng + 0.005,
//               imageUrl:
//                   'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?q=80&w=200&auto=format&fit=crop',
//             ),
//             ProductModel(
//               id: 'fake_2',
//               name: 'Canon Camera',
//               category: 'cameras',
//               price: 450.0,
//               rating: 4.5,
//               distance: 0.8,
//               locationName: 'Fake Location 2',
//               ownerId: 'fake_user_2',
//               latitude: userLat - 0.004, // تحتك بشوية
//               longitude: userLng - 0.002,
//               imageUrl:
//                   'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=200&auto=format&fit=crop',
//             ),
//             ProductModel(
//               id: 'fake_3',
//               name: 'Camping Tent',
//               category: 'camping',
//               price: 150.0,
//               rating: 4.2,
//               distance: 2.1,
//               locationName: 'Fake Location 3',
//               ownerId: 'fake_user_3',
//               latitude: userLat + 0.002, // يمينك بشوية
//               longitude: userLng - 0.006,
//               imageUrl:
//                   'https://images.unsplash.com/photo-1504280390467-336338e55fb9?q=80&w=200&auto=format&fit=crop',
//             ),
//           ]);

//           // 🔴 ----- نهاية الداتا الوهمية ----- 🔴

//           emit(
//             ViewMapLoaded(
//               products: filteredProducts,
//               userLatitude: userLat,
//               userLongitude: userLng,
//               userFirstName: firstName,
//             ),
//           );
//         });
//       });
//     } catch (e) {
//       emit(ViewMapError(e.toString()));
//     }
//   }
// }

