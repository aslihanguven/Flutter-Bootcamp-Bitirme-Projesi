import 'package:bootcamp_bitirme_projesi/data/repository/kullanici_repo.dart';
import 'package:bootcamp_bitirme_projesi/ui/screen/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors.dart';
import '../../data/entity/yemekler.dart';
import '../cubit/sepet_cubit.dart';

class YemeklerDetaySayfa extends StatefulWidget {
  Yemekler yemek;


  YemeklerDetaySayfa({required this.yemek});

  @override
  State<YemeklerDetaySayfa> createState() => _YemeklerDetaySayfaState();
}

class _YemeklerDetaySayfaState extends State<YemeklerDetaySayfa> {

  var urepo= UserRepository();
  late int yemek_siparis_adet = 1;
  String kullanici_adi = "Aslihan";


  @override
  Widget build(BuildContext context) {
    var yemek = widget.yemek;
    int toplam_fiyat = int.parse(yemek.yemek_fiyat) * yemek_siparis_adet;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detaylar", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, fontFamily: "Solitreo"),),
        centerTitle: true,
        backgroundColor: orange,
      ),
      body: Column(
        children: [
          Container(
            width: 500,
            height: 250,
            child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"
            ),
          ),
          Container(
            width: 500,
            height: 270,
            color: orange1,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(yemek.yemek_adi, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                Container(
                  width:  150,
                  height: 80,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          yemek_siparis_adet != 1 ? yemek_siparis_adet -= 1 : yemek_siparis_adet;
                        });
                      }, icon: Icon(Icons.remove_circle_outline, color: Colors.white70, size: 35,),),
                      Text("$yemek_siparis_adet", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){
                        setState(() {
                          yemek_siparis_adet += 1;
                        });
                      },
                        icon: Icon(Icons.add_box_outlined, color: Colors.white70,size: 35,),),
                    ],
                  ),
                ),
                Text("Toplam Fiyat : ${toplam_fiyat} ₺", style: TextStyle(fontWeight: FontWeight.bold
                    ,fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(onPressed: (){
                context.read<SepetCubit>().sepeteEkle(widget.yemek, kullanici_adi , yemek_siparis_adet)
                    .then((value) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${yemek_siparis_adet} Adet ${widget.yemek.yemek_adi} sepete eklendi !")));});
              }, child: Text("SEPETE EKLE",
                style: TextStyle(fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa()));
      }, child: Icon(Icons.shopping_basket_outlined), backgroundColor: orange,),
    );
  }
}
