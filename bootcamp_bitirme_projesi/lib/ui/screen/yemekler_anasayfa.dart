import 'package:bootcamp_bitirme_projesi/ui/screen/sepet_sayfa.dart';
import 'package:bootcamp_bitirme_projesi/ui/screen/yemekler_detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../colors.dart';
import '../../data/entity/yemekler.dart';
import '../cubit/yemekler_cubit.dart';

class YemeklerAnasayfa extends StatefulWidget {
  const YemeklerAnasayfa({Key? key}) : super(key: key);

  @override
  State<YemeklerAnasayfa> createState() => _YemeklerAnasayfaState();
}

class _YemeklerAnasayfaState extends State<YemeklerAnasayfa> {

  bool aramaYapiliyoMu = false;
  int _selectedIndex=1;

  @override
  void initState() {
    super.initState();
    context.read<YemeklerCubit>().yemekleriAl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
       title: aramaYapiliyoMu ?
           TextField(decoration: const InputDecoration(hintText: "Yemek Ara"), onChanged: (aramaSonucu){
             context.read<YemeklerCubit>().ara(aramaSonucu);
           },) :
           const Text("YEMEKLER", style: TextStyle(fontFamily: "Solitreo"),),
        actions: [
          aramaYapiliyoMu ?
              IconButton(onPressed: (){
                setState(() {
                  aramaYapiliyoMu = false;
                });
                context.read<YemeklerCubit>().yemekleriAl();
              }, icon: const Icon(Icons.clear)) :
              IconButton(onPressed: () {
                setState(() {
                  aramaYapiliyoMu = true;
                });
              }, icon: const Icon(Icons.search)),
        ],
      ),

      body: BlocBuilder<YemeklerCubit, List<Yemekler>>(
        builder: (context, yemekListesi ){
          if(yemekListesi.isNotEmpty){
            return GridView.builder(
                itemCount: yemekListesi!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/2.5,
                ),
                itemBuilder: (context, index){
                  var yemek = yemekListesi[index];
                  return
                    Container(
                      margin: EdgeInsets.all(8.0),
                      width: 185,
                      height: 200,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 105,
                                width: 105,
                                child: Image(image: NetworkImage("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",),)),
                            SizedBox(height: 10,),
                            Text(yemek.yemek_adi, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("${yemek.yemek_fiyat} ₺", style: TextStyle(color: Colors.black,fontSize: 16),),
                            ElevatedButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => YemeklerDetaySayfa(yemek: yemek,)));
                            }, child: Text("SİPARİŞ VER", style: TextStyle(color: renkUc),),
                              style: ElevatedButton.styleFrom(backgroundColor: orange),
                            ),
                          ],
                        ),
                      ),
                    );
                });

          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa()));
      }, child: Icon(Icons.shopping_basket_outlined, color: orange,),
        backgroundColor: Colors.white,
      ),
    );
  }
}
