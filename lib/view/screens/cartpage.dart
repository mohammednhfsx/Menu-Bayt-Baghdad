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
                  cartBody(context)
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

      // --------------------- يتم ربطها مع الاصناف المضافة ---------------------
      Text("اصناف 3",
      style: TextStyle(
        color: AppColors.greyText,
        fontWeight: .bold
      ),),

      // --------------------- ثابت (سلة الطلبات) ---------------------
      Text("سلة الطلبات",
      style: TextStyle(
        color: AppColors.white,
        fontWeight: .bold
      ),),

      // --------------------- ثابت (دكمة الرجوع) ---------------------
      CustomButton(
        width: AppSize.screenWidth(context) * 0.10,
        height: AppSize.screenHeight(context) * 0.10,
        onTap: (){

        },
        backgroundColor: AppColors.cardColor,
        shape: BoxShape.circle,
        foregroundColor: AppColors.white,
        child: Icon(Icons.arrow_forward_ios),
      ),
    ],
  );
}

Widget cartBody(BuildContext context){
  return Column(
    spacing: 25,
    children: [
      // Items (تستخدم List View لاحقا)
      Container(
        height: AppSize.screenHeight(context) * 0.12,
        width: AppSize.screenWidth(context) * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 15,
            mainAxisAlignment: .end,
            children: [
              // --------------------- Delete Button / Add More or Remove Buttons ---------------------
              Column(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .start,
                children: [
                  CustomButton(
                      width: 30,
                      height: 30,
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                      child: Icon(Icons.delete_outlined)
                  ),
                  Container(
                    width: 95,
                    height: 37,
                    decoration: BoxDecoration(
                      color: AppColors.background.withOpacity(0.5),
                      border: Border.all(
                        color: AppColors.border
                      ),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFE65100), Color(0xFFFF9800)]
                              )
                            ),
                            child: Icon(Icons.add,
                            color: Colors.black,
                            size: 20,),
                          ),
                        ),
                        Text("1",
                        style: TextStyle(
                          color: AppColors.white
                        ),),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFFE65100), Color(0xFFFF9800)]
                                )
                            ),
                            child: Icon(Icons.remove,
                              color: Colors.black,
                              size: 20,),
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
              Spacer(),

              // --------------------- Item Information ---------------------
              Column(
                mainAxisAlignment: .spaceEvenly,
                crossAxisAlignment: .end,
                children: [
                  Text("دولمة عراقية",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("ورق عنب محشي بالرز والخضار على النار الهادئة",
                  style: TextStyle(
                    color: AppColors.greyText,
                    fontSize: 10
                  ),),
                  Text("18,000 د.ع",
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold
                  ),),
                ],
              ),

              // --------------------- Item Photo ---------------------
              Container(
                width: AppSize.screenWidth(context) * 0.20,
                height: AppSize.screenHeight(context) * 0.20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                        image: AssetImage("assets/images/Dolma.jpg"),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ],
          ),
        ),
      ),

      // --------------------- Coupon Container ---------------------
      TextFormField(
        cursorColor: AppColors.greyText,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  foregroundColor: Colors.black,
                ),
                child: Text("تطبيق")),
          ),
          suffixIcon: Icon(Icons.sell_outlined,
          color: AppColors.primaryOrange,),
          hintText: "ادخل كوبون الخصم",
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold
          ),
          filled: true,
          fillColor: AppColors.searchFill.withOpacity(0.3),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: AppColors.border
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: AppColors.border
            )
          )
        ),
      ),

      // --------------------- Items Information Container (يتم ربطها لاحقا مع معلومات الاصناف) ---------------------
      Container(
        height: AppSize.screenHeight(context) * 0.20,
        width: AppSize.screenWidth(context) * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.cardColor
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: .spaceAround,
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("18,000 د.ع",
                    style: TextStyle(
                        color: AppColors.white
                    ),),
                  Text("المجموع الفرعي",
                  style: TextStyle(
                    color: AppColors.greyText
                  ),),
                ],
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("0,000 د.ع",
                    style: TextStyle(
                        color: AppColors.white
                    ),),
                  Text("الخصم",
                    style: TextStyle(
                        color: AppColors.greyText
                    ),),
                ],
              ),
              Divider(
                color: AppColors.greyText,
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("18,000 د.ع",
                    style: TextStyle(
                        color: AppColors.white
                    ),),
                  Text("الاجمالي",
                    style: TextStyle(
                        color: AppColors.greyText
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),

      // --------------------- Complete Button (يتم ربطها لاحقا مع الكونتينر الخاص بمعلومات الاصناف) ---------------------
      GestureDetector(
        onTap: (){},
        child: Container(
          width: AppSize.screenWidth(context),
          height: AppSize.screenHeight(context) * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE65100), Color(0xFFFF9800)]
              )
          ),
          child: Center(
              child: Text("اتمام الطلب ، 18,000 د.ع",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),)
          )
        ),
      ),
    ],
  );
}
