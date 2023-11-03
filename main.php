<?php

function deletePerson($id) {
    $xml = new DOMDocument;
    $xml->load('data.xml');

    $xpath = new DOMXPath($xml);
    $persons = $xpath->query("/data/person[id='$id']");

    foreach ($persons as $person) {
        $person->parentNode->removeChild($person);
    }

    $xml->save('data.xml');
}

// Check if delete request is received
if (isset($_GET['deleteId'])) {
    $deleteId = $_GET['deleteId'];
    deletePerson($deleteId);

    // Redirect back to main.php to display the updated data
    header('Location: main.php');
    exit();
}




if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Form submitted, process the data and update XML

    $xml = new DOMDocument;
    $xml->load('data.xml');

    // Get form data
    $newPerson = $xml->createElement('person');
    $newPerson->appendChild($xml->createElement('id', $xml->getElementsByTagName('person')->length + 1)); // Assuming ID is auto-incremented
    $newPerson->appendChild($xml->createElement('name', $_POST['newName']));
    $newPerson->appendChild($xml->createElement('gender', $_POST['newGender']));
    $newPerson->appendChild($xml->createElement('nativeName', $_POST['newNative']));
    $newPerson->appendChild($xml->createElement('foreignName', $_POST['newForeign']));

    $xml->documentElement->appendChild($newPerson);
    $xml->save('data.xml');

    // Redirect back to main.php to display the updated data
    header('Location: main.php');
    exit();
}

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

// Set search parameter after creating XSLT processor
$proc->setParameter('', 'search', $searchTerm);

// Enable PHP functions in XSLT
$proc->registerPHPFunctions();

// Transform XML using XSLT and output the result
echo $proc->transformToXML($xml);
?>
