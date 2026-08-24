import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rentora/features/notifications/data/models/notification_model.dart';
import 'package:rentora/features/notifications/manager/notifications_cubit.dart';
import 'package:rentora/features/notifications/manager/notifications_state.dart';
import 'package:rentora/features/notifications/presentation/widgets/notification_card.dart';
import '../../../../helpers/test_helper.dart';

class MockNotificationsCubit extends MockCubit<NotificationsState>
    implements NotificationsCubit {}

void main() {
  testWidgets('renders unread notification content and time', (tester) async {
    final cubit = MockNotificationsCubit();
    when(() => cubit.state).thenReturn(NotificationsInitial());
    final notification = NotificationModel(
      id: 'n1',
      title: 'Booking update',
      body: 'Your request changed',
      type: 'booking',
      relatedId: 'b1',
      isRead: false,
      createdAt: Timestamp.fromDate(
        DateTime.now().subtract(const Duration(minutes: 5)),
      ),
    );
    await tester.pumpApp(
      BlocProvider<NotificationsCubit>.value(
        value: cubit,
        child: NotificationCard(notification: notification),
      ),
    );
    expect(find.text('Booking update'), findsOneWidget);
    expect(find.text('Your request changed'), findsOneWidget);
    expect(find.text('5m ago'), findsOneWidget);
  });
}
