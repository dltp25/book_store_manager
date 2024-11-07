part of 'import_product_bloc.dart';

class ImportProductState extends Equatable {
  final bool isLoading;
  final List<ImportProductModel> history;
  final DateTime? time;

  const ImportProductState({
    this.isLoading = true,
    this.history = const [],
    this.time,
  });

  @override
  List<Object?> get props => [isLoading, history, time];

  ImportProductState copyWith({
    bool? isLoading,
    List<ImportProductModel>? history,
    DateTime? time,
  }) {
    return ImportProductState(
      isLoading: isLoading ?? this.isLoading,
      history: history ?? this.history,
      time: time ?? this.time,
    );
  }
}
