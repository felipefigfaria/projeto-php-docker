<?php
require __DIR__ . '/../vendor/autoload.php';

use Slim\Factory\AppFactory;
use App\Routes;

$app = AppFactory::create();
Routes::register($app);
$app->run();