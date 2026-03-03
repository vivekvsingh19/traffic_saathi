import '../models/violation.dart';

/// Mock violation data for Uttar Pradesh
final List<Violation> mockViolations = [
  const Violation(
    title: 'No Helmet',
    fineFirst: 1000,
    fineRepeat: 2000,
    licenseSeizable: false,
    vehicleSeizable: false,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Bina helmet ke driving karna Motor Vehicles Act Section 129 ke under offence hai. Pehli baar ₹1000 aur dobaara ₹2000 fine lagega. Police sirf challan kaategi, license ya gaadi seize nahi kar sakti.',
  ),
  const Violation(
    title: 'No Seatbelt',
    fineFirst: 1000,
    fineRepeat: 1000,
    licenseSeizable: false,
    vehicleSeizable: false,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Seatbelt na lagana Section 194B(1) ke under fine hai. ₹1000 ka challan lagega. License ya gaadi seize nahi hogi. Sirf receipt-wala challan dena zaroori hai.',
  ),
  const Violation(
    title: 'Triple Riding',
    fineFirst: 1000,
    fineRepeat: 2000,
    licenseSeizable: false,
    vehicleSeizable: false,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Two-wheeler par do se zyada sawari baithana Section 128 ka violation hai. ₹1000 pehli baar aur ₹2000 dobaara fine lagega. Gaadi ya license seize nahi hoga.',
  ),
  const Violation(
    title: 'Over Speeding',
    fineFirst: 1000,
    fineRepeat: 2000,
    licenseSeizable: true,
    vehicleSeizable: false,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Speed limit se zyada speed se chalana Section 183 ka offence hai. ₹1000 se ₹2000 fine. License seize ho sakta hai agar bahut zyada speed ho. Gaadi seize nahi hogi.',
  ),
  const Violation(
    title: 'Drink & Drive',
    fineFirst: 10000,
    fineRepeat: 15000,
    licenseSeizable: true,
    vehicleSeizable: true,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Sharaab peeke gaadi chalana Section 185 ke under serious offence hai. ₹10,000 fine aur 6 mahine tak jail ho sakti hai. License cancel ho sakta hai aur gaadi seize hogi.',
  ),
  const Violation(
    title: 'No Registration Certificate (RC)',
    fineFirst: 2000,
    fineRepeat: 5000,
    licenseSeizable: false,
    vehicleSeizable: true,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'RC ke bina gaadi chalana Section 39 ka violation hai. ₹2000 se ₹5000 fine. Gaadi seize ho sakti hai kyunki bina RC ke gaadi ka ownership prove nahi hota.',
  ),
  const Violation(
    title: 'No Driving License (DL)',
    fineFirst: 5000,
    fineRepeat: 10000,
    licenseSeizable: false,
    vehicleSeizable: true,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Bina license ke gaadi chalana Section 3 ka serious violation hai. ₹5000 se ₹10,000 fine lagega. Gaadi seize ho sakti hai. Police station jaana pad sakta hai.',
  ),
  const Violation(
    title: 'No Insurance',
    fineFirst: 2000,
    fineRepeat: 4000,
    licenseSeizable: false,
    vehicleSeizable: true,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Bina insurance ke gaadi chalana Section 196 ka offence hai. ₹2000 pehli baar aur ₹4000 dobaara. Gaadi seize ho sakti hai. Third-party insurance toh compulsory hai.',
  ),
  const Violation(
    title: 'Wrong Side Driving',
    fineFirst: 1000,
    fineRepeat: 2000,
    licenseSeizable: true,
    vehicleSeizable: false,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Galat side se gaadi chalana Section 184 ke under dangerous driving hai. ₹1000 se ₹2000 fine. License seize ho sakta hai. Bahut khatarnaak violation hai.',
  ),
  const Violation(
    title: 'Mobile While Driving',
    fineFirst: 1000,
    fineRepeat: 2000,
    licenseSeizable: false,
    vehicleSeizable: false,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Driving karte waqt phone use karna Section 184 ke under hai. ₹1000 se ₹2000 fine lagta hai. License ya gaadi seize nahi hogi, lekin dangerous driving mein count ho sakta hai.',
  ),
  const Violation(
    title: 'Jumping Red Light',
    fineFirst: 1000,
    fineRepeat: 2000,
    licenseSeizable: false,
    vehicleSeizable: false,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Red light todna Section 119 ka violation hai. ₹1000 se ₹2000 fine lagta hai. Agar CCTV mein pakde gaye toh online challan aayega.',
  ),
  const Violation(
    title: 'No Pollution Certificate (PUC)',
    fineFirst: 1000,
    fineRepeat: 2000,
    licenseSeizable: false,
    vehicleSeizable: false,
    receiptMandatory: true,
    cashAllowed: false,
    simpleExplanation:
        'Bina PUC ke gaadi chalana Section 190(2) ka offence hai. ₹1000 se ₹2000 fine lagega. PUC har 6 mahine mein renew karwana zaroori hai.',
  ),
];
