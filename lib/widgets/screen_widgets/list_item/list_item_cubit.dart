import 'package:bloc/bloc.dart';
import 'package:money_manager/common/load_status.dart';

import '../../../models/transaction.dart';
import '../../../repositories/api.dart';

part 'list_item_state.dart';

class ListItemCubit extends Cubit<ListItemState> {
  Api api;

  ListItemCubit(this.api) : super(ListItemState.init());

  Future<void> loadData(int monthIdx) async {
    emit(state.copyWith(
        loadStatus: LoadStatus.Loading, selectedMonths: monthIdx));
    try {
      var months = await api.getMonths();
      emit(state.copyWith(months: months));
      var total = await api.getTotal();
      emit(state.copyWith(total: total));
      List<Transaction> trans = months.isEmpty
          ? []
          : await api.getTransaction(state.months[state.selectedMonths]);
      emit(state.copyWith(
          trans: trans, loadStatus: LoadStatus.Done));
    } catch (ex) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }
}
