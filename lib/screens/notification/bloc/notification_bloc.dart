import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/constant/enum.dart';
import 'package:book_store_manager/models/notification_model.dart';
import 'package:book_store_manager/repositories/notification_repository.dart';
import 'package:book_store_manager/repositories/user_repository.dart';
import 'package:book_store_manager/utils/dialog_utils.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository _notiRepository;
  final UserRepository _userRepository;

  StreamSubscription? _notiStream;

  NotificationBloc(this._notiRepository, this._userRepository)
      : super(const NotificationState()) {
    on<LoadNotificationEvent>(_onLoadNoti);
    on<LoadMoreNotiEvent>(_onLoadMore);
    on<StreamUpdateEvent>(_onStreamUpdate);
    on<MarkAllAsReadEvent>(_onMarkAllAsRead);
    on<ReadNotificationEvent>(_onReadNoti);
  }

  @override
  Future<void> close() async {
    _notiStream?.cancel();
    _notiStream = null;
    super.close();
  }

  _onLoadNoti(LoadNotificationEvent event, Emitter emit) {
    emit(state.copyWith(viewType: event.type, number: 20, isLoading: true));

    _notiStream?.cancel();
    _notiStream = null;
    _notiStream = _notiRepository
        .notiStream(state.viewType, state.number)
        .listen((streamEvent) async {
      if (streamEvent.docs.isNotEmpty) {
        List<NotificationModel> notis = [];

        final futureGroups = await Future.wait(streamEvent.docs.map(
          (e) => _userRepository.getUserLiteModel(e.data()['userId']),
        ));

        for (int i = 0; i < streamEvent.size; i++) {
          var docData = streamEvent.docs[i];
          notis.add(
            NotificationModel.fromJson(
              docData.id,
              futureGroups[i].name,
              futureGroups[i].avatar,
              docData.data(),
            ),
          );
        }

        if (!isClosed) {
          add(StreamUpdateEvent(notis: notis));
        }
      } else {
        if (!isClosed) {
          add(const StreamUpdateEvent(notis: []));
        }
      }
    });
  }

  _onLoadMore(LoadMoreNotiEvent event, Emitter emit) {
    if (state.notis.length >= state.number) {
      int newLength = state.number + 20;
      emit(state.copyWith(number: newLength));

      _notiStream?.cancel();
      _notiStream = null;
      _notiStream = _notiRepository
          .notiStream(state.viewType, state.number)
          .listen((streamEvent) async {
        if (streamEvent.docs.isNotEmpty) {
          List<NotificationModel> notis = [];

          final futureGroups = await Future.wait(streamEvent.docs.map(
            (e) => _userRepository.getUserLiteModel(e.data()['userId']),
          ));

          for (int i = 0; i < streamEvent.size; i++) {
            var docData = streamEvent.docs[i];
            notis.add(
              NotificationModel.fromJson(
                docData.id,
                futureGroups[i].name,
                futureGroups[i].avatar,
                docData.data(),
              ),
            );
          }

          if (!isClosed) {
            add(StreamUpdateEvent(notis: notis));
          }
        } else {
          if (!isClosed) {
            add(const StreamUpdateEvent(notis: []));
          }
        }
      });
    }
  }

  _onStreamUpdate(StreamUpdateEvent event, Emitter emit) {
    emit(state.copyWith(notis: event.notis, isLoading: false));
  }

  _onMarkAllAsRead(MarkAllAsReadEvent event, Emitter emit) async {
    DialogUtils.showLoading();

    await _notiRepository.readAllNoti();

    DialogUtils.hideLoading();
  }

  _onReadNoti(ReadNotificationEvent event, Emitter emit) async {
    await _notiRepository.updateIsReadNoti(event.notiId, event.isRead);
  }
}
