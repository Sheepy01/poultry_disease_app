import 'dart:io';

import 'package:intl/intl.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

import '../utils/app_config.dart';

class PdfService {
  const PdfService();

  Future<void> generateReport({
    required File image,

    required Map<String, dynamic> disease,

    required String confidence,

    required List symptoms,

    required List actions,
  }) async {
    try {
      final pdf = pw.Document();

      final regularFont = await PdfGoogleFonts.notoSansDevanagariRegular();

      final boldFont = await PdfGoogleFonts.notoSansDevanagariBold();

      final imageBytes = await image.readAsBytes();

      final pdfImage = pw.MemoryImage(imageBytes);

      final now = DateTime.now();

      final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(now);

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,

          margin: const pw.EdgeInsets.all(32),

          theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),

          build: (context) => [
            pw.Center(
              child: pw.Text(
                'Poultry AI Disease Report',

                style: pw.TextStyle(
                  fontSize: 28,

                  fontWeight: pw.FontWeight.bold,

                  color: PdfColors.teal800,
                ),
              ),
            ),

            pw.SizedBox(height: 25),

            pw.Container(
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(20),

                border: pw.Border.all(color: PdfColors.teal200, width: 2),
              ),

              child: pw.ClipRRect(
                horizontalRadius: 20,

                verticalRadius: 20,

                child: pw.Image(pdfImage, height: 250, fit: pw.BoxFit.contain),
              ),
            ),

            pw.SizedBox(height: 30),

            _sectionTitle('Detected Disease'),

            pw.SizedBox(height: 10),

            pw.Text(
              AppConfig.text(disease, fallback: "Unknown Disease"),

              style: pw.TextStyle(
                fontSize: 22,

                fontWeight: pw.FontWeight.bold,

                color: PdfColors.red700,
              ),
            ),

            pw.SizedBox(height: 25),

            _sectionTitle('Confidence Score'),

            pw.SizedBox(height: 10),

            pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),

              decoration: pw.BoxDecoration(
                color: PdfColors.teal50,

                borderRadius: pw.BorderRadius.circular(12),
              ),

              child: pw.Text(
                '$confidence%',

                style: pw.TextStyle(
                  fontSize: 20,

                  fontWeight: pw.FontWeight.bold,

                  color: PdfColors.teal800,
                ),
              ),
            ),

            pw.SizedBox(height: 30),

            _sectionTitle('Clinical Symptoms'),

            pw.SizedBox(height: 12),

            ...(symptoms).map(
              (symptom) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 8),

                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,

                  children: [
                    pw.Text('• ', style: const pw.TextStyle(fontSize: 14)),

                    pw.Expanded(
                      child: pw.Text(
                        AppConfig.text(symptom),

                        style: const pw.TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            pw.SizedBox(height: 30),

            _sectionTitle('Immediate Actions'),

            pw.SizedBox(height: 12),

            ...(actions).map(
              (action) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 8),

                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,

                  children: [
                    pw.Text('• ', style: const pw.TextStyle(fontSize: 14)),

                    pw.Expanded(
                      child: pw.Text(
                        AppConfig.text(action),

                        style: const pw.TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            pw.SizedBox(height: 40),

            pw.Divider(),

            pw.SizedBox(height: 10),

            pw.Text(
              'Generated On',

              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
            ),

            pw.SizedBox(height: 5),

            pw.Text(formattedDate, style: const pw.TextStyle(fontSize: 13)),

            pw.SizedBox(height: 20),

            pw.Center(
              child: pw.Text(
                'AI-assisted Poultry Disease Detection System',

                style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
              ),
            ),
          ],
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async {
          return pdf.save();
        },
      );

      print("PDF Generated Successfully");
    } catch (e) {
      print("PDF Generation Error: $e");
    }
  }

  pw.Widget _sectionTitle(String title) {
    return pw.Text(
      title,

      style: pw.TextStyle(
        fontSize: 20,

        fontWeight: pw.FontWeight.bold,

        color: PdfColors.black,
      ),
    );
  }
}
