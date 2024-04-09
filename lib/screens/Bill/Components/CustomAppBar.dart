import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 8, left: 32, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bills",
            style: TextStyle(
              fontSize: 40,
              fontFamily: "Made Tommy",
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 38,
                height: 38,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: const Color(0xffFFE3CD),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/panaroma");
                    },
                    child: const Icon(
                      CupertinoIcons.question,
                      color: Color(0xff4B2900),
                      size: 20,
                    )),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Find the Counter",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
