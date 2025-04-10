import 'package:flutter/material.dart';
import 'rabbitmq_service.dart'; // Asegúrate de importar el archivo creado

class ParkingScreen extends StatefulWidget {
  @override
  _ParkingScreenState createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  List<bool> parkingStatus = [true, true, true, false, true, false];

  @override
  void initState() {
    super.initState();

    RabbitMQService.onMessage = (mensaje) {
      try {
        // Convertir el mensaje a lista de booleanos
        List<dynamic> data = mensaje.contains("[")
            ? mensaje.replaceAll("[", "").replaceAll("]", "").split(",")
            : [];
        List<bool> updatedStatus = data.map((e) => e.trim() == "true").toList();

        if (updatedStatus.length == parkingStatus.length) {
          setState(() {
            parkingStatus = updatedStatus;
          });
        }
      } catch (e) {
        print("Error al procesar mensaje: $e");
      }
    };

    RabbitMQService.connect();
  }

  @override
  void dispose() {
    RabbitMQService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Image.asset("assets/images/logo.png", height: 100),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: parkingStatus.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Espacio de estacionamiento ${index + 1}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Image.asset(
                        parkingStatus[index]
                            ? "assets/images/verificado.png"
                            : "assets/images/denegado.png",
                        height: 80,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
