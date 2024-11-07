part of 'import_product_bloc.dart';

sealed class ImportProductEvent extends Equatable {
  const ImportProductEvent();

  @override
  List<Object> get props => [];
}

class LoadImportProductHistory extends ImportProductEvent {
  final DateTime time;

  const LoadImportProductHistory({required this.time});
}

class StreamUpdateEvent extends ImportProductEvent {
  final List<ImportProductModel> imports;

  const StreamUpdateEvent({required this.imports});
}
