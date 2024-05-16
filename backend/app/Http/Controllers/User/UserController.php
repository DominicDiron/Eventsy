<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Planner;
use App\Models\Favourite;
use App\Models\Booking;
use App\Models\UserFavourite;
use DB;

class UserController extends Controller
{
    public function getCurrentUser($currentUserId)
    {
       $currentUser = User::find($currentUserId);
       return $currentUser;
    }

    public function updateUserProfile(Request $request,$userId)
    {
        $user = User::find($userId);
        if(!$user){
            return response()->json(['error'=>'User not found'],404);
        }

        $validatedData = $request->validate([
            'name' => 'string',
            'profileIMG' => 'url',
            'location' => 'string',
            'email' => 'email',
            'contact' => 'string',
        ]);
        if($user->update($validatedData)){
            return response()->json(['message' => 'User profile updated Successfully']);
        }        
    }

    public function userFavouritePlanner($currentId,$plannerId)
    {
        $favouritePlannerID = $plannerId;
        $currentUser = User::find($currentId);
        $favouritePlanner = Planner::find($favouritePlannerID);
        $currentUser->userFavourites()->attach($favouritePlanner);

        return response()->json(['message' => 'Added to Favourite']);
    }
    public function getUserFavourites($currentUserId)
    {
        $favourites = Planner::join('userfavourites', 'userfavourites.favouritePlannerID', '=', 'planners.plannerID')
        ->where('userfavourites.userID', $currentUserId)
        ->select('userfavourites.*', 'planners.*') // Select all columns from both tables
        ->get();

        return response()->json($favourites); // correct code
    }
    public function deleteUserFavourite($favouriteId)
    {
        $data = DB::table('userfavourites')->where('favouriteID',$favouriteId);
        $data->delete();
        return response()->json(['message'=>'successfully deleted']);
    }

    public function userHirePlanner($currentUserId,$plannerId)
    {
        $currentUser = User::find($currentUserId);
        $bookedPlanner = Planner::find($plannerId);
        $currentUser->userbookings()->attach($bookedPlanner);
        
        return response()->json(['message' => 'Hire request sent.', 'status' => 'pending']);
    }

    public function getSentRequests($currentUserId)
    {
        $pendingRequests = Planner::join('userbookings', 'userbookings.bookedPlannerID', '=', 'planners.plannerID')
        ->where('userbookings.userID', $currentUserId)
        ->where('userbookings.status', 'pending')
        ->select('userbookings.*', 'planners.*') // Select all columns from both tables
        ->get();

        return response()->json($pendingRequests); // correct code
    }

    public function cancelSentRequest($userBookingID)
    {
        $data = DB::table('userbookings')->where('userbookingID',$userBookingID);
        $data->delete();
        return response()->json(['message'=>'successfully deleted']);
    }

    public function getUserInProgress($currentUserId)
    {
        $inProgress = Planner::join('userbookings', 'userbookings.bookedPlannerID', '=', 'planners.plannerID')
        ->where('userbookings.userID', $currentUserId)
        ->where('userbookings.status', 'inProgress')
        ->select('userbookings.*', 'planners.*') // Select all columns from both tables
        ->get();

        return response()->json($inProgress); // correct code
    }
    public function getUserComplete($currentUserId)
    {
        $completed = Planner::join('userbookings', 'userbookings.bookedPlannerID', '=', 'planners.plannerID')
        ->where('userbookings.userID', $currentUserId)
        ->where('userbookings.status', 'completed')
        ->select('userbookings.*', 'planners.*') // Select all columns from both tables
        ->get();

        return response()->json($completed); // correct code
    }
    public function getUserCancelled($currentUserId)
    {
        $cancelled = Planner::join('userbookings', 'userbookings.bookedPlannerID', '=', 'planners.plannerID')
        ->where('userbookings.userID', $currentUserId)
        ->where('userbookings.status', 'cancelled')
        ->select('userbookings.*', 'planners.*') // Select all columns from both tables
        ->get();

        return response()->json($cancelled); // correct code
    }
}
