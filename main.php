<?php
// Load XML file
$xml = new DOMDocument;
$xml->load('data.xml');

// Load XSLT file
$xslt = new DOMDocument;
$xslt->load('main.xslt');

// Create XSLT processor
$proc = new XSLTProcessor;
$proc->importStyleSheet($xslt);

// Set search parameter
$searchTerm = isset($_GET['search']) ? $_GET['search'] : '';

// Enable PHP functions in XSLT
$proc->registerPHPFunctions();

// Set search parameter after creating XSLT processor
$proc->setParameter('', 'search', $searchTerm);

// Transform XML using XSLT and output the result
echo $proc->transformToXML($xml);
?>
