import "package:flutter/material.dart";
import "package:menubaghdad/core/theme/app_colors.dart";
import "package:menubaghdad/view/widgets/custom_button.dart";
import "../../core/size_extensions.dart";

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                children: [
                  cartHeader(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget cartHeader(BuildContext context){
  return Row(
    mainAxisAlignment: .spaceBetween,
    children: [
      Text("اصناف 3",
      style: TextStyle(
        color: AppColors.greyText,
        fontWeight: .bold
      ),),
      Text("سلة الطلبات",
      style: TextStyle(
        color: AppColors.whiteText,
        fontWeight: .bold
      ),),
      CustomButton(
        width: AppSize.screenWidth(context) * 0.10,
        height: AppSize.screenHeight(context) * 0.10,
        onTap: (){

        },
        backgroundColor: AppColors.cardColor,
        shape: BoxShape.circle,
        foregroundColor: AppColors.whiteText,
        child: Icon(Icons.arrow_forward_ios),
      ),
    ],
  );
}
