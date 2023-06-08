<?php

use App\Http\Controllers\API\ApiAspirasiController;
use App\Http\Controllers\Api\ApiIuranController;
use App\Http\Controllers\Api\ApiWargaController;
use App\Http\Controllers\Api\ApiKegiatanController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::apiResource('/user', App\Http\Controllers\Api\ApiUserController::class);
Route::apiResource('/warga', App\Http\Controllers\Api\ApiWargaController::class);
Route::apiResource('/aspirasi', App\Http\Controllers\Api\ApiAspirasiController::class);
Route::apiResource('/kegiatan', App\Http\Controllers\Api\ApiKegiatanController::class);
Route::apiResource('/iuran', App\Http\Controllers\Api\ApiIuranController::class);
Route::post('/login', App\Http\Controllers\Api\ApiLoginController::class);
Route::get('/list-aspirasi/{id}',[ApiAspirasiController::class, 'listAspirasi']);
Route::get('/list-iuran/{id}',[ApiIuranController::class, 'listIuran']);
Route::get('/verifikasi/{id}{value}',[ApiIuranController::class, 'verifikasi']);
Route::get('/activity',[ApiKegiatanController::class, 'activity']);
Route::post('/updateAkun',[ApiWargaController::class, 'updateAkun']);
Route::post('/update-iuran',[ApiIuranController::class, 'updateIuran']);

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });
