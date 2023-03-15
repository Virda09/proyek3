<?php

use App\Http\Controllers\AspirasiController;
use App\Http\Controllers\IuranController;
use App\Http\Controllers\KegiatanController;
use App\Http\Controllers\KoordinatorController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\WargaController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::middleware('auth')->group(function () {
    Route::get('profile', [ProfileController::class, 'index'])->name('profile');
    Route::put('profile', [ProfileController::class, 'update'])->name('profile.update');

    Route::resource('warga', WargaController::class)->names('warga');
    Route::resource('iuran', IuranController::class)->names('iuran');
    Route::resource('kegiatan', KegiatanController::class)->names('kegiatan');
    Route::resource('aspirasi', AspirasiController::class)->names('aspirasi');
    Route::resource('koordinator', KoordinatorController::class)->names('koordinator');
});

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');
