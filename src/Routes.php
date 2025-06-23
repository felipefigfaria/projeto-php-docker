<?php
namespace App;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Slim\App;

class Routes
{
    public static function register(App $app): void
    {
        $app->get('/', function (ServerRequestInterface $request, ResponseInterface $response) {
            $response->getBody()->write(json_encode(['message' => 'Hello from SIG 2000!']));
            return $response->withHeader('Content-Type', 'application/json');
        });

        $app->get('/ping', function (ServerRequestInterface $request, ResponseInterface $response) {
            $response->getBody()->write(json_encode(['pong' => true]));
            return $response->withHeader('Content-Type', 'application/json');
        });
    }
}