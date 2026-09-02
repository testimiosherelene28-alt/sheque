<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');

$dataFile = 'queue.json';

if (!file_exists($dataFile)) {
    $initialData = ['last_issued' => 0, 'current' => 0, 'queue' => []];
    file_put_contents($dataFile, json_encode($initialData));
}

$data = json_decode(file_get_contents($dataFile), true);
$action = $_GET['action'] ?? 'status';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($action === 'issue') {
        $data['last_issued']++;
        $data['queue'][] = $data['last_issued'];
    } elseif ($action === 'next') {
        if (!empty($data['queue'])) {
            $data['current'] = array_shift($data['queue']);
        }
    } elseif ($action === 'reset') {
        $data = ['last_issued' => 0, 'current' => 0, 'queue' => []];
    }
    file_put_contents($dataFile, json_encode($data));
}

$next = !empty($data['queue']) ? $data['queue'][0] : null;

echo json_encode([
    'current' => $data['current'] ?: null,
    'next'    => $next,
    'waiting' => count($data['queue'])
]);