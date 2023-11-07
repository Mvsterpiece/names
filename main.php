<?php if (isset($_GET['code'])) { die(highlight_file('data.xml', 1)); } ?>
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
    updateJsonFile($xml);
}
function xmlToArray($xml) {
    $array = [];

    foreach ($xml->getElementsByTagName('person') as $person) {
        $personData = [];
        foreach ($person->childNodes as $node) {
            $personData[$node->nodeName] = $node->nodeValue;
        }
        $array['person'][] = $personData;
    }

    return $array;
}


function updateJsonFile($xml) {
    $data = xmlToArray($xml);

    $json = json_encode($data, JSON_PRETTY_PRINT);

    file_put_contents('data.json', $json);
}


if (isset($_GET['deleteId'])) {
    $deleteId = $_GET['deleteId'];
    deletePerson($deleteId);
    header('Location: main.php');
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $xml = new DOMDocument;
    $xml->load('data.xml');

    $newPerson = $xml->createElement('person');
    $newPerson->appendChild($xml->createElement('id', $xml->getElementsByTagName('person')->length + 1));
    $newPerson->appendChild($xml->createElement('name', $_POST['newName']));
    $newPerson->appendChild($xml->createElement('gender', $_POST['newGender']));
    $newPerson->appendChild($xml->createElement('nativeName', $_POST['newNative']));
    $newPerson->appendChild($xml->createElement('foreignName', $_POST['newForeign']));

    $xml->documentElement->appendChild($newPerson);
    $xml->save('data.xml');
    updateJsonFile($xml);

    header('Location: main.php');
    exit();
}

$xml = new DOMDocument;
$xml->load('data.xml');

$xslt = new DOMDocument;
$xslt->load('main.xslt');

$proc = new XSLTProcessor;
$proc->importStyleSheet($xslt);

$searchTerm = isset($_GET['search']) ? $_GET['search'] : '';
$proc->setParameter('', 'search', $searchTerm);
$proc->registerPHPFunctions();

echo $proc->transformToXML($xml);
?>
