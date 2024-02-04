<?php
// Include the main TCPDF library (search for installation path).
require_once 'dompdf/autoload.inc.php';

// reference the Dompdf namespace
use Dompdf\Dompdf;

// script arguments/params
$fileName = stripslashes($argv[1]);
$html = stripslashes($argv[2]);

// Get the Rails root folder path
$railsRoot = dirname(dirname(dirname(__FILE__)));
$tmpPath = $railsRoot . '/tmp';
$filePath = $tmpPath . '/' . $fileName;

// instantiate and use the dompdf class
$dompdf = new Dompdf([
  'logOutputFile' => '',
  // authorize DomPdf to download fonts and other Internet assets
  'isRemoteEnabled' => true,
  'isFontSubsettingEnabled' => true,
  'defaultMediaType' => 'all',
  // all directories must exist and not end with /
  'fontDir' => $tmpPath,
  'fontCache' => $tmpPath,
  'tempDir' => $tmpPath,
  'chroot' => $tmpPath,
]);

$options = $dompdf->getOptions();
// $options->setDefaultFont('Courier');
$dompdf->setOptions($options);

$dompdf->loadHtml($html);

// (Optional) Setup the paper size and orientation
$dompdf->setPaper('A4', 'portrait');

// Render the HTML as PDF
$dompdf->render();
$output = $dompdf->output();

// Create file in the tmp path
file_put_contents($filePath, $output);
