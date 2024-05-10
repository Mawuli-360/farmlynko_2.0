import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(1.h),
            height: 2.h,
            width: 2.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(1.h))),
            child: Padding(
              padding: EdgeInsets.only(left: 0.7.h),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.green,
                size: 2.h,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: Html(
            data:
                "<h1> Farmlynco</h1><h1>Benefits for Rice Farmers:</h1> <ol><li><strong>Market Access:</strong> Through Farmlynco, rice farmers gain direct access to a network of potential buyers, eliminating the need for intermediaries and ensuring fairer prices for their produce.</li><li><strong>Increased Sales:</strong> By connecting with a wider pool of buyers, farmers can sell their rice more efficiently and in larger quantities, boosting their overall sales and revenue.</li> <li><strong>Price Transparency:</strong> The app provides real-time market information, enabling farmers to make informed decisions about pricing and timing of sales, thus maximizing their profits.</li><li><strong>Reduced Wastage:</strong> By facilitating quicker transactions, Farmlynco helps reduce the risk of rice spoilage, leading to less wastage and higher overall productivity.</li><li><strong>Community Support:</strong> The app fosters a sense of community among rice farmers by providing a platform for communication, knowledge sharing, and support.</li></ol><h1>Benefits for Potential Buyers:</h1><ol><li><strong>Diverse Options:</strong> Buyers gain access to a diverse range of rice varieties and qualities from different farmers, allowing them to choose products that best suit their needs and preferences.</li><li><strong>Quality Assurance:</strong> Farmlynco offers tools for farmers to showcase the quality of their rice through descriptions, images, and possibly even certifications, giving buyers confidence in their purchases.</li><li><strong>Direct Communication:</strong> Buyers can communicate directly with farmers through the app, enabling them to discuss specific requirements, negotiate prices, and establish long-term partnerships.</li><li><strong>Convenience:</strong> With Farmlynco, buyers can easily browse through available rice listings, place orders, and arrange for delivery or pickup, all within a single platform, saving time and effort.</li><li><strong>Supporting Local Farmers:</strong> By purchasing rice directly from farmers, buyers contribute to the sustainability of local agriculture, supporting small-scale producers and promoting food security.</li></ol><h1>Privacy Protection:</h1><ol><li><strong>Anonymous Listings:</strong> Farmers and buyers have the option to create anonymous listings or profiles, protecting their identities and personal information from being publicly displayed.</li><li><strong>Data Encryption:</strong> Farmlynco employs robust encryption techniques to safeguard user data, ensuring that sensitive information such as contact details and transaction histories remain secure.</li><li><strong>Opt-In Sharing:</strong> Users have full control over their data and can choose to share specific information with other users or third parties only when necessary, respecting their privacy preferences.</li><li><strong>Transparent Policies:</strong> The app maintains clear and transparent privacy policies, informing users about how their data is collected, stored, and used, and providing options for opting out of certain data practices.</li><li><strong>Regular Audits:</strong> Farmlynco conducts regular privacy audits and assessments to identify and address any potential vulnerabilities or compliance issues, ensuring ongoing protection of user privacy.</li></ol>",
          ),
        ),
      ),
    );
  }
}
