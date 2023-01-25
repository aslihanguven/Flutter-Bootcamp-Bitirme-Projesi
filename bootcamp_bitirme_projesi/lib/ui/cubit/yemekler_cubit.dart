import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/yemekler.dart';
import '../../data/repository/yemeklerdao_repo.dart';

class YemeklerCubit extends Cubit<List<Yemekler>>{
  YemeklerCubit() : super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> yemekleriAl() async{
    var liste = await yrepo.tumYemekleriGoster();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async{
    var liste = await yrepo.yemekAra(aramaKelimesi);
    emit(liste);
  }
}