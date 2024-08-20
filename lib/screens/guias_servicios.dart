import 'package:flutter/material.dart';
import 'package:push_notificaciones/screens/guias.dart';
import 'package:push_notificaciones/screens/otros.dart';
import 'package:push_notificaciones/screens/servicios.dart';



class GuiasServicios extends StatefulWidget {
  const GuiasServicios({super.key});

  @override
  State<GuiasServicios> createState() => _GuiasServiciosState();
}

class _GuiasServiciosState extends State<GuiasServicios> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                  child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledColor: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const Guias()),
                  );
                },
                color: const Color.fromARGB(255, 43, 43, 44),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.2,
                    vertical: size.height * 0.02,
                  ),
                  child: const Text(
                    'Guias',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
              const SizedBox(height: 100,),
              Container(
                padding: const EdgeInsets.all(5),
                child: MaterialButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  const Servicios()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledColor:Colors.green,
                color: const Color.fromARGB(255, 43, 43, 44), 
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.2,
                    vertical: size.height * 0.02,
                  ),
                  child: const Text('Servicios', style: TextStyle(color: Colors.white),),
                ),
                ),
              ),
              const SizedBox(height: 100,),
              Container(
                padding: const EdgeInsets.all(5),
                child: MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Otros()));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledColor: const Color.fromARGB(255, 75, 31, 46),
                  color: const Color.fromARGB(255, 43, 43, 44), 
                  child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.2,
                    vertical: size.height * 0.02,
                  ),
                  child: const Text('Otros', style: TextStyle(color: Colors.white),),
                ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
