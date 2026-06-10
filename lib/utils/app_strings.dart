import 'app_config.dart';

class AppStrings {
  static Map<String, String> get strings {
    if (AppConfig.language == "hi") {
      return {
        "app_title": "पोल्ट्री रोग पहचान",
        "app_brand": "पोल्ट्री एआई",
        "splash_subtitle": "एआई-संचालित पोल्ट्री रोग पहचान",
        "onboarding_ai_title": "एआई-संचालित पहचान",
        "onboarding_ai_description":
            "ऑफलाइन एआई इमेज सिमिलैरिटी विश्लेषण का उपयोग करके पोल्ट्री रोग पैटर्न का विश्लेषण करें।",
        "onboarding_scan_title": "स्मार्ट रोग विश्लेषण",
        "onboarding_scan_description":
            "अपलोड की गई छवियों से समझाने योग्य एआई जानकारी के साथ पोल्ट्री रोग पहचानें।",
        "onboarding_report_title": "रिपोर्ट बनाएं",
        "onboarding_report_description":
            "रोग निष्कर्षों और सुझावों को पेशेवर PDF रिपोर्ट के रूप में निर्यात करें।",
        "skip": "छोड़ें",
        "start": "शुरू करें",
        "next": "आगे",
        "home": "होम",
        "catalogue": "रोग सूची",
        "home_subtitle": "एआई-सहायित पोल्ट्री रोग पहचान और जागरूकता प्रणाली",
        "home_hero_title": "स्मार्ट पोल्ट्री रोग विश्लेषण",
        "home_hero_description":
            "एआई-संचालित इमेज सिमिलैरिटी विश्लेषण से पोल्ट्री रोग पहचानें।",
        "start_detection": "पहचान शुरू करें",
        "disease_awareness": "रोग जागरूकता",
        "newcastle_disease": "रानीखेत रोग",
        "newcastle_awareness_description":
            "पोल्ट्री में सांस और तंत्रिका संबंधी लक्षण पैदा करने वाला अत्यधिक संक्रामक वायरल रोग।",
        "aflatoxicosis_disease": "अफ्लाटॉक्सिकोसिस रोग",
        "aflatoxicosis_awareness_description":
            "अफ्लाटॉक्सिन-दूषित चारे से होने वाला विष-संबंधी रोग। यह मुख्य रूप से यकृत को नुकसान पहुंचाता है और पोल्ट्री में खराब वृद्धि, कमजोरी तथा उल्लेखनीय मृत्यु दर का कारण बन सकता है।",
        "ai_based_detection": "एआई-आधारित पहचान",
        "ai_based_detection_description":
            "यह ऐप पोल्ट्री रोग पहचान के लिए एआई-संचालित इमेज सिमिलैरिटी विश्लेषण का उपयोग करता है।",
        "detect_disease": "रोग पहचान",
        "upload_poultry_image": "पोल्ट्री छवि अपलोड करें",
        "upload_chicken_image": "मुर्गी की तस्वीर चुनें",
        "ai_analyze_patterns": "एआई रोग पैटर्न का विश्लेषण करेगा",
        "ai_scanning_in_progress": "एआई स्कैनिंग जारी है",
        "analyzing_poultry_patterns":
            "पोल्ट्री रोग पैटर्न का विश्लेषण किया जा रहा है...",
        "unable_to_analyze_image": "छवि का विश्लेषण नहीं किया जा सका।",
        "detection_result": "पहचान परिणाम",
        "detected_disease": "पहचाना गया रोग",
        "ai_analysis_complete": "एआई विश्लेषण पूरा हुआ",
        "unknown_disease": "अज्ञात रोग",
        "no_overview_available": "कोई सारांश उपलब्ध नहीं है।",
        "detected_finding": "पहचाना गया निष्कर्ष",
        "no_finding_available": "कोई निष्कर्ष उपलब्ध नहीं है।",
        "clinical_symptoms": "क्लिनिकल लक्षण",
        "symptoms": "लक्षण",
        "immediate_actions": "तत्काल कार्रवाई",
        "mortality": "मृत्यु दर",
        "unknown": "अज्ञात",
        "export_pdf_report": "PDF रिपोर्ट निर्यात करें",
        "generating_pdf_report": "PDF रिपोर्ट बनाई जा रही है...",
        "treatment": "उपचार",
        "differential_diagnosis": "विभेदक निदान",
        "reference_images": "संदर्भ छवियां",
        "catalogue_subtitle": "पोल्ट्री रोग छवियां और निष्कर्ष देखें।",
        "search_disease_or_finding": "रोग या निष्कर्ष खोजें...",
        "pdf_report_title": "पोल्ट्री एआई रोग रिपोर्ट",
        "confidence_score": "विश्वास स्कोर",
        "generated_on": "बनाया गया",
        "pdf_footer": "एआई-सहायित पोल्ट्री रोग पहचान प्रणाली",
        "pdf_generated_successfully": "PDF सफलतापूर्वक बन गई",
        "pdf_generation_error": "PDF बनाने में त्रुटि",
      };
    }

    return {
      "app_title": "Poultry Disease Detection",
      "app_brand": "Poultry AI",
      "splash_subtitle": "AI-powered Poultry Disease Detection",
      "onboarding_ai_title": "AI-powered Detection",
      "onboarding_ai_description":
          "Analyze poultry disease patterns using offline AI image similarity analysis.",
      "onboarding_scan_title": "Smart Disease Analysis",
      "onboarding_scan_description":
          "Detect poultry diseases from uploaded images with explainable AI insights.",
      "onboarding_report_title": "Generate Reports",
      "onboarding_report_description":
          "Export disease findings and recommendations as professional PDF reports.",
      "skip": "Skip",
      "start": "Start",
      "next": "Next",
      "home": "Home",
      "catalogue": "Catalogue",
      "home_subtitle":
          "AI-assisted Poultry Disease Detection & Awareness System",
      "home_hero_title": "Smart Poultry Disease Analysis",
      "home_hero_description":
          "Detect poultry diseases using AI-powered image similarity analysis.",
      "start_detection": "Start Detection",
      "disease_awareness": "Disease Awareness",
      "newcastle_disease": "Newcastle Disease",
      "newcastle_awareness_description":
          "Highly contagious viral disease causing respiratory and neurological symptoms in poultry.",
      "aflatoxicosis_disease": "Aflatoxicosis Disease",
      "aflatoxicosis_awareness_description":
          "A toxin-related disease caused by aflatoxin-contaminated feed. It primarily damages the liver and can result in poor growth, weakness, and significant mortality in poultry.",
      "ai_based_detection": "AI-based Detection",
      "ai_based_detection_description":
          "This app uses AI-powered image similarity analysis for poultry disease identification.",
      "detect_disease": "Disease Detection",
      "upload_poultry_image": "Upload Poultry Image",
      "upload_chicken_image": "Upload Chicken Image",
      "ai_analyze_patterns": "AI will analyze disease patterns",
      "ai_scanning_in_progress": "AI Scanning in Progress",
      "analyzing_poultry_patterns": "Analyzing poultry disease patterns...",
      "unable_to_analyze_image": "Unable to analyze image.",
      "detection_result": "Detection Result",
      "detected_disease": "Detected Disease",
      "ai_analysis_complete": "AI Analysis Complete",
      "unknown_disease": "Unknown Disease",
      "no_overview_available": "No overview available.",
      "detected_finding": "Detected Finding",
      "no_finding_available": "No finding available.",
      "clinical_symptoms": "Clinical Symptoms",
      "symptoms": "Symptoms",
      "immediate_actions": "Immediate Actions",
      "mortality": "Mortality",
      "unknown": "Unknown",
      "export_pdf_report": "Export PDF Report",
      "generating_pdf_report": "Generating PDF report...",
      "treatment": "Treatment",
      "differential_diagnosis": "Differential Diagnosis",
      "reference_images": "Reference Images",
      "catalogue_subtitle": "Browse poultry disease images and findings.",
      "search_disease_or_finding": "Search disease or finding...",
      "pdf_report_title": "Poultry AI Disease Report",
      "confidence_score": "Confidence Score",
      "generated_on": "Generated On",
      "pdf_footer": "AI-assisted Poultry Disease Detection System",
      "pdf_generated_successfully": "PDF Generated Successfully",
      "pdf_generation_error": "PDF Generation Error",
    };
  }
}
