<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\Admin;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');



Route::get('/', 'App\Http\Controllers\HomeController@home');
Route::get('/register', 'App\Http\Controllers\Auth\AuthController@RegistrationForm');
Route::post('/register', 'App\Http\Controllers\Auth\AuthController@Register');
Route::get('/login', 'App\Http\Controllers\Auth\AuthController@LoginForm');
Route::post('/login', 'App\Http\Controllers\Auth\AuthController@Login');
Route::get('/logout', 'App\Http\Controllers\Auth\AuthController@logout');
Route::put('DeleteUser','App\Http\Controllers\Auth\AuthController@DeleteUser');
Route::get('/GetWallet', 'App\Http\Controllers\HomeController@ShowWallet');
Route::get('ShowTrips', 'App\Http\Controllers\HomeController@ShowTrips');
Route::post('/ExpandTrip', 'App\Http\Controllers\HomeController@ExpandTrip');
Route::post('/ShowType', 'App\Http\Controllers\HomeController@ShowType');
Route::post('/book', 'App\Http\Controllers\HomeController@book'); //trip_id, person_count
Route::post('unbook','App\Http\Controllers\HomeController@unbook');
Route::post('EditBooking','App\Http\Controllers\HomeController@EditBooking'); //trip-id, person_count
Route::get('/test','App\Http\Controllers\HomeController@testFunction');
Route::post('AddFavourite', 'App\Http\Controllers\HomeController@AddToFavourite'); 
Route::get('GetFavourite', 'App\Http\Controllers\HomeController@GetFavourites');
Route::post('RemoveFavourite', 'App\Http\Controllers\HomeController@RemoveFavourite');
Route::get('/DeleteNotifications','App\Http\Controllers\HomeController@DeleteNotifications'); 
Route::get('/ShowNotifications','App\Http\Controllers\HomeController@ShowNotifications');
Route::post('/search','App\Http\Controllers\HomeController@search');
Route::post('EditPassword', 'App\Http\Controllers\Auth\AuthController@EditUserPassword');
Route::post('EditUsername', 'App\Http\Controllers\Auth\AuthController@EditUsername');
Route::post('EditPhoto', 'App\Http\Controllers\Auth\AuthController@EditUserImage');
Route::middleware([Admin::class])->group(function(){
    Route::post('/AdminRegister', 'App\Http\Controllers\Auth\AuthController@CreateAdmin');
    Route::post('/CreateTrip', 'App\Http\Controllers\AdminController@CreateTrip');
    Route::post('/charge', 'App\Http\Controllers\AdminController@ChargeMoney'); //amount, user (username in user)
    Route::post('/EditTrip','App\Http\Controllers\AdminController@EditTrip');
    Route::post('/DeleteTrip','App\Http\Controllers\AdminController@DeleteTrip');
    Route::post('/AddPhoto', 'App\Http\Controllers\AdminController@AddPhoto');
    Route::post('ExpiryDelete', 'App\Http\Controllers\AdminController@ExpiryDelete'); //end_date
});