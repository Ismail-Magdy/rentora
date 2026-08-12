import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  late StreamSubscription<InternetStatus> _subscription;
  Timer? _debounceTimer;

  NetworkCubit() : super(NetworkInitial()) {
    _subscription = InternetConnection().onStatusChange.listen((
      InternetStatus status,
    ) {
      if (status == InternetStatus.connected) {
        _debounceTimer?.cancel();
        emit(NetworkConnected());
      } else {
        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(seconds: 10), () {
          emit(NetworkDisconnected());
        });
      }
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _subscription.cancel();
    return super.close();
  }
}
