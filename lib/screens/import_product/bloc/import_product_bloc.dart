import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_store_manager/extensions/datetime_ex.dart';
import 'package:book_store_manager/models/import_product_model.dart';
import 'package:book_store_manager/repositories/import_repository.dart';
import 'package:book_store_manager/utils/converter.dart';
import 'package:equatable/equatable.dart';

part 'import_product_event.dart';
part 'import_product_state.dart';

class ImportProductBloc extends Bloc<ImportProductEvent, ImportProductState> {
  final ImportRepository _importRepository;

  StreamSubscription? _importStream;

  ImportProductBloc(this._importRepository)
      : super(const ImportProductState()) {
    on<LoadImportProductHistory>(_onLoadHistory);
    on<StreamUpdateEvent>(_onStreamUpdate);
  }

  @override
  Future<void> close() async {
    _importStream?.cancel();
    _importStream = null;
    super.close();
  }

  _onLoadHistory(LoadImportProductHistory event, Emitter emit) async {
    if (event.time.getMonthAndYear() != state.time?.getMonthAndYear()) {
      _importStream?.cancel();
      _importStream = null;
      emit(state.copyWith(isLoading: true, time: event.time));

      _importStream = _importRepository
          .importHistoryStream(event.time)
          .listen((streamEvent) async {
        if (streamEvent.docs.isNotEmpty) {
          List<ImportProductModel> history = [];

          final products = await Future.wait(streamEvent.docs.map(
            (e) => _importRepository.getAllProductInImport(e['products']),
          ));

          for (int i = 0; i < products.length; i++) {
            history.add(
              ImportProductModel(
                id: streamEvent.docs[i].id,
                time: cvToDate(streamEvent.docs[i].data()['time']),
                products: products[i],
              ),
            );
          }

          add(StreamUpdateEvent(imports: history));
        } else {
          add(const StreamUpdateEvent(imports: []));
        }
      });
    }
  }

  _onStreamUpdate(StreamUpdateEvent event, Emitter emit) {
    emit(state.copyWith(history: event.imports, isLoading: false));
  }
}
