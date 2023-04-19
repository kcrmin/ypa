import 'package:flutter/material.dart';
import 'package:ypa/util/goal_dialog.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.teal,
      height: 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Goals",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 19,
              ),
            ),
            GestureDetector(
              onTap: (){
                showGoalDialog(context);
              },
              child: Text(
                String.fromCharCode(Icons.add.codePoint),
                style: TextStyle(
                  inherit: false,
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: Icons.add.fontFamily,
                  package: Icons.add.fontPackage,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
