<?php
// Загрузка XML-файла
$xml = new DOMDocument;
$xml->load('data.xml');

// Загрузка XSLT-файла
$xslt = new DOMDocument;
$xslt->load('main.xslt');

// Создание процессора XSLT
$proc = new XSLTProcessor;
$proc->importStyleSheet($xslt);

// Установка параметра поиска
$searchTerm = isset($_GET['search']) ? $_GET['search'] : '';
$proc->setParameter('', 'search', $searchTerm);

// Преобразование XML с использованием XSLT и вывод результата
echo $proc->transformToXML($xml);
?>
