<?php
namespace Mpdf;

/**
 * Minimal stub implementation of the mPDF library.
 * This class provides just enough functionality for
 * generate_paper.php to create PDFs when the real
 * mPDF package is not installed.
 */
class Mpdf
{
    /** @var string Accumulated HTML content */
    private string $html = '';

    /**
     * Constructor.
     *
     * @param array $config Optional configuration (ignored).
     */
    public function __construct(array $config = [])
    {
        // Real mPDF supports configuration but this stub ignores it.
    }

    /**
     * Append HTML content to the internal buffer.
     *
     * @param string $html HTML markup to render.
     */
    public function WriteHTML(string $html): void
    {
        $this->html .= $html;
    }

    /**
     * Output the generated PDF using the underlying FPDF library.
     *
     * @param string $filename Output filename.
     * @param string $dest     Destination mode ('I' for inline).
     * @return string|null     PDF string when $dest === 'S'.
     */
    public function Output(string $filename = '', string $dest = 'I')
    {
        if (!class_exists('FPDF')) {
            require_once __DIR__ . '/../fpdf.php';
        }
        $pdf = new \FPDF();
        $pdf->AddPage();
        $pdf->SetFont('Helvetica', '', 12);
        $text = strip_tags($this->html);
        $pdf->MultiCell(0, 5, $text);
        return $pdf->Output($filename, $dest);
    }
}
