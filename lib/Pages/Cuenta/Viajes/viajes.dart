import 'package:flutter/material.dart';
import 'package:tllevo_driver/Const/const.dart';
import 'package:tllevo_driver/Pages/Cuenta/Viajes/detalle.dart';

class Viajes extends StatelessWidget {
  Viajes({Key? key, required this.data}) : super(key: key);
Map data;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            width: size.width * 1,
            height: size.height * 0.17,
            color: Const().yellow,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: size.height * 0.04,
                  left: size.width * 0.02,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                ),
                Positioned(
                  top: size.height * 0.09,
                  child: Text(
                    'Viajes',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.041,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        height: 1.1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          infoViajes(size, '7/5/22  3:54 p.m.', '\$43.58', 'Monto Ganado', context),
          infoViajes(size, '7/5/22  3:54 p.m.', '\$43.58', 'Monto Ganado', context),
          infoViajes(size, '7/5/22  3:54 p.m.', '\$43.58', 'Monto Ganado', context),
          infoViajes(size, '7/5/22  3:54 p.m.', '\$43.58', 'Monto Ganado', context),
          infoViajes(size, '7/5/22  3:54 p.m.', '\$43.58', 'Monto Ganado', context),
        ],
      ),
    );
  }

  Widget infoViajes(Size size, String date, String price, String code, context) {
    return Padding(
      padding: EdgeInsets.only(
          top: size.height * 0.02,
          left: size.width * 0.1,
          right: size.width * 0.1),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Detalle(data: data,date: date, code: code, img: 'Assets/Images/mapDetalle.png', price: price))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.021,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      height: 1.1),
                ),
                Text(
                  price,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.021,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      height: 1),
                ),
              ],
            ),
            Text(
              code,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: size.height * 0.021,
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: size.height * 0.17,
              width: size.width * 1,
              child: Image.asset(
                'Assets/Images/mapDetalle.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.black,
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20,
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Divider(
              thickness: 1.0,
              height: size.height * 0.03,
              color: const Color(0xffB3B3B3),
            ),
          ],
        ),
      ),
    );
  }
}
