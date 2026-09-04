import '../models/scheme_model.dart';
import '../../../channel_partners/data/models/partner_model.dart';
import '../../../documents/data/models/document_model.dart';

/// Phase 1 dummy data (Section 21: "First make the entire journey work
/// with dummy data. Then connect real backend services.").
/// Every field here is realistic in *shape* only - replace with verified
/// scheme data before any real demo, per Section 15 (Data Trust).
class DummyData {
  DummyData._();

  static final List<SchemeModel> schemes = [
    SchemeModel(
      id: 'scheme_001',
      name: 'PM Employment Generation Programme (PMEGP)',
      targetGroup: 'New micro-enterprises, priority to SC/ST/Women/PwD',
      eligibilitySummary: 'Age 18+, no income ceiling for general category projects up to limit',
      incomeLimit: 300000,
      maxProjectCost: 2500000,
      maxLoanAmount: 2000000,
      interestRatePercent: 11.0,
      repaymentMonths: 84,
      moratoriumMonths: 6,
      purpose: 'Manufacturing, service, trading micro-enterprises',
      requiredDocuments: const [
        'Aadhaar Card',
        'Caste Certificate (if applicable)',
        'Project Report',
        'Educational Qualification Certificate',
        'Bank Passbook',
      ],
      applicationMethod: 'Online via KVIC portal, then District Industries Centre verification',
      officialSource: 'https://www.kviconline.gov.in/pmegpeportal/',
      lastVerified: DateTime(2026, 8, 1),
    ),
    SchemeModel(
      id: 'scheme_002',
      name: 'Stand-Up India Scheme',
      targetGroup: 'SC/ST and Women entrepreneurs (Greenfield enterprises)',
      eligibilitySummary: 'At least 51% shareholding/controlling stake with SC/ST or Woman entrepreneur',
      incomeLimit: 250000,
      maxProjectCost: 10000000,
      maxLoanAmount: 10000000,
      interestRatePercent: 10.5,
      repaymentMonths: 84,
      moratoriumMonths: 18,
      purpose: 'Manufacturing, services, trading, agri-allied sector',
      requiredDocuments: const [
        'Aadhaar Card',
        'Caste Certificate / Gender proof',
        'Project Report',
        'Business Address Proof',
      ],
      applicationMethod: 'Apply via standupmitra.in, routed to nearest bank branch',
      officialSource: 'https://www.standupmitra.in/',
      lastVerified: DateTime(2026, 7, 20),
    ),
    SchemeModel(
      id: 'scheme_003',
      name: 'Mudra Loan - Shishu Category',
      targetGroup: 'Small and micro business owners, all categories',
      eligibilitySummary: 'Loan requirement up to ₹50,000, non-corporate small business',
      incomeLimit: 500000,
      maxProjectCost: 50000,
      maxLoanAmount: 50000,
      interestRatePercent: 9.5,
      repaymentMonths: 60,
      moratoriumMonths: 0,
      purpose: 'Small trading, tailoring, small manufacturing units',
      requiredDocuments: const [
        'Aadhaar Card',
        'PAN Card',
        'Business Proof',
      ],
      applicationMethod: 'Apply at any nationalized bank / NBFC / MFI branch',
      officialSource: 'https://www.mudra.org.in/',
      lastVerified: DateTime(2026, 8, 10),
    ),
  ];

  static final List<PartnerModel> partners = [
    PartnerModel(
      id: 'partner_001',
      name: 'State Bank of India - Bhimavaram Branch',
      address: 'Main Road, Bhimavaram, Andhra Pradesh',
      contact: '+91 88888 00001',
      latitude: 16.5449,
      longitude: 81.5212,
      distanceKm: 1.8,
      eligibleSchemeIds: const ['scheme_001', 'scheme_003'],
    ),
    PartnerModel(
      id: 'partner_002',
      name: 'Andhra Pradesh District Industries Centre',
      address: 'Collectorate Complex, Bhimavaram',
      contact: '+91 88888 00002',
      latitude: 16.5410,
      longitude: 81.5230,
      distanceKm: 2.4,
      eligibleSchemeIds: const ['scheme_001'],
    ),
    PartnerModel(
      id: 'partner_003',
      name: 'Canara Bank - Vijayawada Regional Office',
      address: 'MG Road, Vijayawada, Andhra Pradesh',
      contact: '+91 88888 00003',
      latitude: 16.5062,
      longitude: 80.6480,
      distanceKm: 42.6,
      eligibleSchemeIds: const ['scheme_002', 'scheme_003'],
    ),
  ];

  static List<DocumentModel> documentsFor(String schemeId) {
    final scheme = schemes.firstWhere((s) => s.id == schemeId);
    return scheme.requiredDocuments
        .map((d) => DocumentModel(name: d, description: 'Required for ${scheme.name}'))
        .toList();
  }
}
