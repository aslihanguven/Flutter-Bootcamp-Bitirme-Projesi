import 'dart:convert';
import 'package:dio/dio.dart';
import '../entity/yemekler.dart';
import '../entity/yemekler_cevap.dart';

class YemeklerDaoRepository{
  List<Yemekler> parseYemeklerCevap(String cevap){
    var jsonVeri = json.decode(cevap);
    var yemeklerCevap = YemeklerCevap.fromJson(jsonVeri);
    return yemeklerCevap.yemekler;
  }

  Future<List<Yemekler>> tumYemekleriGoster() async{
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemeklerCevap(cevap.data.toString());
  }

  Future<List<Yemekler>> yemekAra(String aramaKelimesi) async{
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemeklerCevap(cevap.data).where((element) => element.yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase())).toList();
  }
}
