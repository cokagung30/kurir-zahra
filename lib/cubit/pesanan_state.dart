part of 'pesanan_cubit.dart';

abstract class PesananState extends Equatable {
  const PesananState();

  @override
  List<Object> get props => [];
}

class PesananInitial extends PesananState {}

class PesananLoadedSuccess extends PesananState {
  final List<Pesanan> pesanan;

  PesananLoadedSuccess(this.pesanan);

  @override
  List<Object> get props => [pesanan];
}

class PesananActionSuccess extends PesananState {
  final String message;

  PesananActionSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class PesananActionFailed extends PesananState {
  final String message;

  PesananActionFailed(this.message);

  @override
  List<Object> get props => [message];
}
