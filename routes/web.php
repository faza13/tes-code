<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->post('login', "\App\Http\Controllers\AuthController@login");
$router->post('user', "\App\Http\Controllers\UserController@store");

$router->group(['middleware' => ['auth:web']], function() use ($router) {
    $router->group(['middleware' => [\App\Http\Middleware\AdminMiddleware::class]], function() use ($router) {
        $router->post('class', "\App\Http\Controllers\ClassController@store");
    });
    $router->post('class/check-in', "\App\Http\Controllers\ClassController@checkIn");
    $router->post('class/check-out', "\App\Http\Controllers\ClassController@checkOut");

    $router->get('class/get-class-list', "\App\Http\Controllers\ClassController@getClassList");
    $router->get('class/get-class-by-id/{id}', "\App\Http\Controllers\ClassController@getClassById");
});

