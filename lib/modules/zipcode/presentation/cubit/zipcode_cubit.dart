import 'package:bloc/bloc.dart';
import 'package:search_zipcode/modules/zipcode/domain/usescases/get_address_by_zipcode_usecase.dart';
import 'package:search_zipcode/modules/zipcode/presentation/cubit/zipcode_state.dart';
import '../../../../core/error/failure.dart';

class ZipcodeCubit extends Cubit<ZipcodeState> {
  final GetAddressByZipcodeUsecase getAddressByZipcodeUsecase;

  ZipcodeCubit({required this.getAddressByZipcodeUsecase}) : super(Empty());

  Future<void> getZipcodeInfoEvent(String cep) async {
    emit(Loading());

    final failureOrCEP = await getAddressByZipcodeUsecase(cep);

    failureOrCEP.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (address) => emit(Loaded(address: address)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else if (failure is NetworkFailure) {
      return 'Network Failure';
    } else if (failure is ZipcodeFailure) {
      return 'Cep não encontrado';
    } else {
      return 'Unexpected Error';
    }
  }
}
