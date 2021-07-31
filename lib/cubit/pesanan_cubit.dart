import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kurir_zahra/models/models.dart';
import 'package:kurir_zahra/services/services.dart';

part 'pesanan_state.dart';

class PesananCubit extends Cubit<PesananState> {
  PesananCubit() : super(PesananInitial());

  Future<void> getPesanan() async {
    ApiReturnValue<List<Pesanan>> result = await PesananServices.getPesanan();

    if (result.value != null) {
      emit(PesananLoadedSuccess(result.value!));
    } else {
      emit(PesananActionFailed(result.message!));
    }
  }

  Future<void> uploadProofSend(File file, int pesananId) async {
    bool result = await PesananServices.finishTransaction(file, pesananId);

    if (result) {
      emit(PesananActionSuccess('Bukti pengiriman berhasil diupload'));
    } else {
      emit(PesananActionFailed('Bukti pengiriman gagal diupload'));
    }
  }
}
