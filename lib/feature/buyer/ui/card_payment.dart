import 'package:farmlynko/feature/buyer/provider/cart_provider.dart';
import 'package:farmlynko/routes/navigation.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class CardPayment extends ConsumerStatefulWidget {
  const CardPayment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardPaymentState();
}

class _CardPaymentState extends ConsumerState<CardPayment> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: Colors.green)),
              child: Center(
                child: AppImages.back,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            width: 4.3.h,
            margin: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.h),
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(image: AppImages.avatar),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          )
        ],
        centerTitle: true,
        title: Text(
          "Credit / Debit Card",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
      ),
      body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 8.h,
              ),
              Text(
                "Add Your Card Details",
                style: TextStyle(fontSize: 13.sp),
              ),
              SizedBox(
                height: 0.2.h,
              ),
              SizedBox(
                height: 0.2.h,
              ),
              CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Axis Bank',
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  // cardBgColor: AppColors.cardBgColor,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {}),
              CreditCardForm(
                formKey: formKey,
                obscureCvv: true,
                obscureNumber: true,
                cardNumber: cardNumber,
                cvvCode: cvvCode,
                isHolderNameVisible: true,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                cardHolderName: cardHolderName,
                expiryDate: expiryDate,
                // themeColor: Colors.blue,
                // textColor: Colors.black,
                // cardNumberDecoration: InputDecoration(
                //   labelText: 'Number',
                //   hintText: 'XXXX XXXX XXXX XXXX',
                //   hintStyle: const TextStyle(color: Colors.black),
                //   labelStyle: const TextStyle(color: Colors.black),
                //   focusedBorder: border,
                //   enabledBorder: border,
                // ),
                // expiryDateDecoration: InputDecoration(
                //   hintStyle: const TextStyle(color: Colors.black),
                //   labelStyle: const TextStyle(color: Colors.black),
                //   focusedBorder: border,
                //   enabledBorder: border,
                //   labelText: 'Expired Date',
                //   hintText: 'XX/XX',
                // ),
                // cvvCodeDecoration: InputDecoration(
                //   hintStyle: const TextStyle(color: Colors.black),
                //   labelStyle: const TextStyle(color: Colors.black),
                //   focusedBorder: border,
                //   enabledBorder: border,
                //   labelText: 'CVV',
                //   hintText: 'XXX',
                // ),
                // cardHolderDecoration: InputDecoration(
                //   hintStyle: const TextStyle(color: Colors.grey),
                //   labelStyle: const TextStyle(color: Colors.black),
                //   focusedBorder: border,
                //   enabledBorder: border,
                //   labelText: 'Card Holder',
                // ),
                onCreditCardModelChange: onCreditCardModelChange,
              )
            ]),
          )),
      bottomNavigationBar: CustomButton(
        onTap: () {
          if (formKey.currentState!.validate()) {
            // Form is valid, process payment here
            Navigation.opensuccessPaymentScreen(context: context);
            ref.read(cartProvider.notifier).clearCartAndSelectedAddOns(
                ref.read(selectedAddOnsProvider.notifier));
          }
        },
        title: "Pay",
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
