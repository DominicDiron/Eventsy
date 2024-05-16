<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\User\PlannerController;
use App\Http\Controllers\User\UserController;
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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/test', function(){
    return response([
        'msg'=>'api is working'
    ],200);
});

////////////////////  Authentication  ///////////////////////
Route::post('register',[AuthController::class,'register']);
Route::post('login',[AuthController::class,'login']);



/////////////////// Planners ///////////////////////////
Route::post('/planners',[PlannerController::class,'index']);
Route::post('/getCurrentPlanner/{currentPlannerId}',[PlannerController::class,'getCurrentPlanner']);
Route::post('/updateProfile/{plannerId}',[PlannerController::class,'updateProfile']);

Route::post('/addToFavourite/{currentPlannerId}/{plannerId}',[PlannerController::class,'addToFavourite']);//OK
Route::post('/getFavourites/{plannerId}',[PlannerController::class,'getFavourites']);
Route::post('/deleteFavourite/{favouriteID}',[PlannerController::class,'deleteFavourite']);

Route::post('/getUserBookRequests/{currentPlannerId}',[PlannerController::class,'getUserBookRequests']);//OK
Route::post('/getPlannerInProgress/{currentPlannerId}',[PlannerController::class,'getPlannerInProgress']);//ok
Route::post('/getPlannerCompleted/{currentPlannerId}',[PlannerController::class,'getPlannerCompleted']);//ok
Route::post('/getPlannerCancelled/{currentPlannerId}',[PlannerController::class,'getPlannerCancelled']);//ok

Route::post('/acceptUserRequest/{userbookingID}',[PlannerController::class,'acceptUserRequest']);//OK
Route::post('/cancelUserRequest/{userbookingID}',[PlannerController::class,'cancelUserRequest']);//OK

Route::post('/completeUserBooking/{userbookingID}',[PlannerController::class,'completeUserBooking']);//OK



////////////////Users///////////////////////////////////////
Route::post('/getCurrentUser/{currentUserId}',[UserController::class,'getCurrentUser']);
Route::post('/updateUserProfile/{userId}',[UserController::class,'updateUserProfile']);
Route::post('/userFavouritePlanner/{currentId}/{plannerId}',[UserController::class,'userFavouritePlanner']);
Route::post('/getUserFavourites/{currentUserId}',[UserController::class,'getUserFavourites']);
Route::delete('/deleteUserFavourite/{favouriteID}',[UserController::class,'deleteUserFavourite']);

Route::post('/userHirePlanner/{currentUserId}/{plannerId}',[UserController::class,'userHirePlanner']);
Route::post('/getSentRequests/{currentUserId}',[UserController::class,'getSentRequests']);
Route::delete('/cancelSentRequest/{userBookingID}',[UserController::class,'cancelSentRequest']);

Route::post('/getUserInProgress/{currentUserId}',[UserController::class,'getUserInProgress']);
Route::post('/getUserComplete/{currentUserId}',[UserController::class,'getUserComplete']);
Route::post('/getUserCancelled/{currentUserId}',[UserController::class,'getUserCancelled']);