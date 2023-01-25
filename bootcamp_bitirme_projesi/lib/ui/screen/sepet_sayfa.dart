import 'package:bootcamp_bitirme_projesi/ui/screen/yemekler_anasayfa.dart';
import 'package:bootcamp_bitirme_projesi/ui/screen/yemekler_detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors.dart';
import '../../data/entity/sepet_yemekler.dart';
import '../../data/entity/yemekler.dart';
import '../cubit/sepet_cubit.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({Key? key}) : super(key: key);

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  var sepetToplam = 0;


  @override
  void initState() {
    super.initState();
    context.read<SepetCubit>().al("Aslihan");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => YemeklerAnasayfa()));
        }, icon: Icon(Icons.arrow_back)),
        title: Text("SEPET", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, fontFamily: "Solitreo"),),
        centerTitle: true,
      ),
      body: BlocBuilder<SepetCubit, List<SepetYemekler>>(
        builder: (context, sepetYemekListe) {
          sepetToplam = 0;
          for(var i = 0; i<sepetYemekListe.length; i++){
            sepetToplam += int.parse(sepetYemekListe[i].yemek_fiyat) * int.parse(sepetYemekListe[i].yemek_siparis_adet);
          }
          if(sepetYemekListe.isNotEmpty) {
            return ListView.builder(
                itemCount: sepetYemekListe.length,
                itemBuilder: (context, indeks) {
                  var yemek = sepetYemekListe[indeks];
                  return GestureDetector(
                    onTap: () {
                      var yemekIki = Yemekler(
                          yemek_id: "",
                          yemek_adi: yemek.yemek_adi,
                          yemek_resim_adi: yemek.yemek_resim_adi,
                          yemek_fiyat: yemek.yemek_fiyat);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => YemeklerDetaySayfa(yemek: yemekIki)));
                    },
                    child: Card(
                      color: orange1,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage("http://kasimadalan.pe.hu/yemekresimler/${yemek.yemek_resim_adi}",),
                        ),
                        title: Text("${yemek.yemek_siparis_adet} Adet ${yemek.yemek_adi}", style: TextStyle(color: Colors.black),),
                        subtitle: Text("${int.parse(yemek.yemek_fiyat) * int.parse(yemek.yemek_siparis_adet)} ₺ " , style: TextStyle(color: Colors.black),),
                        trailing: IconButton(onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${yemek.yemek_adi} silinsin mi ?"),
                              action: SnackBarAction(
                                  label: "Evet",
                                  onPressed: () {
                                    context.read<SepetCubit>().sepettenSil(
                                        yemek.sepet_yemek_id,
                                        yemek.kullanici_adi);
                                    if (sepetYemekListe.length == 1) {
                                      setState(() {
                                        sepetYemekListe.clear();
                                        sepetToplam = 0;
                                      });
                                    }
                                  }
                              ),
                            ),
                          );
                        }, icon:
                        Icon(Icons.delete_outlined)),
                      ),
                    ),
                  );
                }
            );
          }else{
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Sepet Boş !", style: TextStyle(fontSize: 22, color: orange,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          height: 50,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Text("Sepeti Onaylıyor Musunuz?"),
                          actions:  [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(child: Text("Hayır", style: TextStyle(color: orange),),onPressed: (){
                                  Navigator.pop(context);
                                }),

                                TextButton(child: Text("Evet", style: TextStyle(color: orange),),onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>YemeklerAnasayfa()));
                                }),
                              ],
                            )
                          ],);
                      }
                  );
                },
                child: Text(
                  "SEPETİ ONAYLA",
                  style: TextStyle(fontSize: 18,fontFamily: "OpenSans-regular"),
                ),
                style: ElevatedButton.styleFrom(primary: orange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
