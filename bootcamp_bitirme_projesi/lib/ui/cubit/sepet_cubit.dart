import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/sepet_yemekler.dart';
import '../../data/entity/yemekler.dart';
import '../../data/repository/sepetdao_repo.dart';

class SepetCubit extends Cubit<List<SepetYemekler>>{
  SepetCubit() : super([]);

  var sRepo = SepetDaoRepository();

  Future<void> sepeteEkle(Yemekler yemek, String kullanici_adi, int yemek_siparis_adet) async{
    await sRepo.sepeteEkle(yemek, kullanici_adi, yemek_siparis_adet);
  }

  Future<void> al(String kullanici_adi) async{
    var liste = await sRepo.sepettenAL(kullanici_adi);
    emit(liste);
  }

  Future<void> sepettenSil(String sepet_yemek_id, String kullanici_adi) async{
    await sRepo.yemekSil(sepet_yemek_id, kullanici_adi);
    await al(kullanici_adi);

  }
}