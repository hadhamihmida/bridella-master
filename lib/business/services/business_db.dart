import 'package:bridella/business/models/business.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessDataBase {
  final CollectionReference business =
      FirebaseFirestore.instance.collection('business');

// not used
  Business? _businessfromFireStore(DocumentSnapshot doc) {
    if (doc.exists) {
      Map<String, dynamic> bizPublicInfos =
          doc.get(FieldPath(const ['publicInfo'])) as Map<String, dynamic>;
      /* List _qrListFromDoc = doc.get(FieldPath(const ['qrCodes']));
      
      List<QrCode> _qrList = List<QrCode>.from(_qrListFromDoc.isNotEmpty
          ? _qrListFromDoc.map((_qr) => QrCode(
              qrId: _qr['qrId'].toString(), qrName: _qr['qrName'].toString()))
          : []); */
      return Business(
          businessId: doc.id,
          businessType: bizPublicInfos['businessType'] is String
              ? bizPublicInfos['businessType']
              : 'Services',
          marketplace: bizPublicInfos['marketPlace'] is Map<String, dynamic>
              ? bizPublicInfos['marketPlace']
              : {},
          logo: bizPublicInfos['logo'] is String ? bizPublicInfos['logo'] : '',
          imgGallery: bizPublicInfos['imageGallery'] is List<dynamic>
              ? bizPublicInfos['imageGallery']
              : [],
          bannerImage: bizPublicInfos['bannerImage'] is String
              ? bizPublicInfos['bannerImage']
              : '',
          businessName: bizPublicInfos['businessName'] is String
              ? bizPublicInfos['businessName']
              : '',
          businessDesc: bizPublicInfos['businessDesc'] is String
              ? bizPublicInfos['businessDesc']
              : '',
          addressLine: bizPublicInfos['address']['line1'] is String
              ? bizPublicInfos['address']['line1']
              : '',
          city: bizPublicInfos['address']['city'] is String
              ? bizPublicInfos['address']['city']
              : '',
          postCode: bizPublicInfos['address']['postCode'] is String
              ? bizPublicInfos['postCode']
              : '',
          country: bizPublicInfos['address']['country'] is String
              ? bizPublicInfos['address']['country']
              : '',
          email:
              bizPublicInfos['email'] is String ? bizPublicInfos['email'] : '',
          infoPhone: bizPublicInfos['infoLine'] is List<dynamic>
              ? bizPublicInfos['infoLine']
              : [],
          ratingNumbers: bizPublicInfos['rating']['amount'] is num
              ? bizPublicInfos['rating']['amount'] as int
              : 1,
          ratingScore: bizPublicInfos['rating']['score'] is num
              ? bizPublicInfos['rating']['score'] as double
              : 5,
          payMethods: bizPublicInfos['payMethods'] is List<dynamic>
              ? bizPublicInfos['payMethods']
              : [],
          visible: bizPublicInfos['visible'] is bool
              ? bizPublicInfos['visible']
              : true);
    } else {
      return null;
    }
  }

// not used
  Stream<Business?> firestoreProBusinessStream(String bid) =>
      business.doc(bid).snapshots().map(_businessfromFireStore);

  Stream<List<Business>>? firestoreProBusinessListStream() {
    try {
      return business
          .where('visible', isEqualTo: true)
          .snapshots()
          .map((biz) => biz.docs.map((doc) {
                Map<String, dynamic> bizPublicInfos =
                    doc.get(FieldPath(const ['publicInfo']))
                        as Map<String, dynamic>;
                List<String> imgList = [];
                /* Map<String, dynamic> bizGallery = doc
              .get(FieldPath(const ['imageGallery'])) as Map<String, dynamic>;
          bizGallery.forEach((k, v) => imgList.add(v));*/
                num ratingNumbers = bizPublicInfos['rating']['amount'] ?? 0;
                num ratingScore = bizPublicInfos['rating']['score'] ?? 0;
                return Business(
                    businessId: doc.id,
                    businessType: bizPublicInfos['businessType'] is String
                        ? bizPublicInfos['businessType']
                        : 'Services',
                    marketplace:
                        bizPublicInfos['marketPlace'] is Map<String, dynamic>
                            ? bizPublicInfos['marketPlace']
                            : {},
                    logo: bizPublicInfos['logo'] is String
                        ? bizPublicInfos['logo']
                        : '',
                    imgGallery: [],
                    bannerImage: bizPublicInfos['bannerImage'] is String
                        ? bizPublicInfos['bannerImage']
                        : '',
                    businessName: bizPublicInfos['businessName'] is String
                        ? bizPublicInfos['businessName']
                        : 'Bridella business',
                    businessDesc: bizPublicInfos['businessDesc'] is String
                        ? bizPublicInfos['businessDesc']
                        : 'No description for the moment',
                    addressLine: bizPublicInfos['address']['line1'] is String
                        ? bizPublicInfos['address']['line1']
                        : '',
                    city: bizPublicInfos['address']['city'] is String
                        ? bizPublicInfos['address']['city']
                        : '',
                    postCode: bizPublicInfos['address']['postCode'] is String
                        ? bizPublicInfos['address']['postCode']
                        : '',
                    country: bizPublicInfos['address']['country'] is String
                        ? bizPublicInfos['address']['country']
                        : '',
                    email: bizPublicInfos['email'] is String
                        ? bizPublicInfos['email']
                        : '',
                    infoPhone: bizPublicInfos['infoLine'] is List<dynamic>
                        ? bizPublicInfos['infoLine']
                        : [],
                    ratingNumbers: ratingNumbers.toInt(),
                    ratingScore: ratingScore.toDouble(),
                    payMethods: bizPublicInfos['payMethods'] is List<dynamic>
                        ? bizPublicInfos['payMethods']
                        : [],
                    visible: doc['visible'] is bool ? doc['visible'] : true);
              }).toList());
    } catch (e) {
      print('the error is ');
      print(e);
    }
  }
}
