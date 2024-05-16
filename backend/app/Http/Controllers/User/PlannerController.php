<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Planner;
use App\Models\Service;
use Illuminate\Http\Request;
use App\Models\Favourite;
use App\Models\Booking;
use App\Models\User;
use DB;

class PlannerController extends Controller
{
    public function index()
    {
        $data = Planner::get();
        return $data;
    }

    public function getCurrentPlanner($currentPlannerId)
    {
       $currentPlanner = Planner::find($currentPlannerId);
       return $currentPlanner;
    }

    public function updateProfile(Request $request,$plannerId)
    {
        $planner = Planner::find($plannerId);

        if(!$planner){
            return response()->json(['error'=>'User not found'],404);
        }

        $validatedData = $request->validate([
            'name' => 'string',
            'profileIMG' => 'url',
            'location' => 'string',
            'dob' => 'date',
            'image1' => 'url',
            'image2' => 'url',
            'image3' => 'url',
            'image4' => 'url',
            'email' => 'email',
            'contact' => 'string',
            'description' => 'string',
            'services' => 'string',
        ]);

        if($planner->update($validatedData)){
            return response()->json(['message' => 'Planner profile updated Successfully']);
        }        
    }

    public function plannerHirePlanner($currentPlannerId,$plannerId)
    {
        $currentPlanner = Planner::find($currentPlannerId);
        $bookedPlanner = Planner::find($plannerId);
        $currentPlanner->plannerbookings()->attach($bookedPlanner);
        
        return response()->json(['message' => 'Hire request sent.', 'status' => 'pending']);
    }

    public function addToFavourite($currentPlannerid,$plannerId)
    {
        $favouritePlannerID = $plannerId;
        $currentUser = Planner::find($currentPlannerid);
        $favouritePlanner = Planner::find($favouritePlannerID);
        $currentUser->favourites()->attach($favouritePlanner);
        
        return response()->json(['message' => 'Added to Favourite']);
    }

    public function getFavourites($currentPlannerId)
    {
        $favourites = Planner::join('plannerfavourites', 'plannerfavourites.favouritePlannerID', '=', 'planners.plannerID')
        ->where('plannerfavourites.plannerID', $currentPlannerId)
        ->select('plannerfavourites.*', 'planners.*') // Select all columns from both tables
        ->get();

        return response()->json($favourites); // correct code
    }

    public function deleteFavourite($favouriteId)
    {
        $data = DB::table('plannerfavourites')->where('favouriteID',$favouriteId);
        $data->delete();
        return response()->json(['message'=>'successfully deleted']);
    }

    

    public function getUserBookRequests($currentPlannerId)
    {
        $pendingRequests = User::join('userbookings', 'userbookings.userID', '=', 'users.UserID')
        ->where('userbookings.bookedPlannerID', $currentPlannerId)
        ->where('userbookings.status', 'pending')
        ->select('userbookings.*', 'users.*') // Select all columns from both tables
        ->get();

        return response()->json($pendingRequests); // correct code
    }
    public function getPlannerInProgress($currentPlannerId)
    {
        $inProgress = User::join('userbookings', 'userbookings.userID', '=', 'users.userID')
        ->where('userbookings.bookedPlannerID', $currentPlannerId)
        ->where('userbookings.status', 'inProgress')
        ->select('userbookings.*', 'users.*') // Select all columns from both tables
        ->get();

        return response()->json($inProgress); // correct code
    }

    public function getPlannerCompleted($currentPlannerId)
    {
        $complete = User::join('userbookings', 'userbookings.userID', '=', 'users.userID')
        ->where('userbookings.bookedPlannerID', $currentPlannerId)
        ->where('userbookings.status', 'completed')
        ->select('userbookings.*', 'users.*') // Select all columns from both tables
        ->get();

        return response()->json($complete); // correct code
    }

    public function getPlannerCancelled($currentPlannerId)
    {
        $cancelled = User::join('userbookings', 'userbookings.userID', '=', 'users.userID')
        ->where('userbookings.bookedPlannerID', $currentPlannerId)
        ->where('userbookings.status', 'cancelled')
        ->select('userbookings.*', 'users.*') // Select all columns from both tables
        ->get();

        return response()->json($cancelled); // correct code
    }

    public function acceptUserRequest(Request $request,$userbookingID)
    {
        $booking = DB::table('userbookings')->where('userbookingID', $userbookingID)->first();
        if (!$booking) {
            return response()->json(['error' => 'Booking ID not found'], 404);
        }

        $result = DB::table('userbookings')
        ->where('userbookingID', $userbookingID)
        ->update(['status' => 'inProgress']);

        if ($result) {
            return response()->json(['message' => 'Request Changed to inProgress successfully']);
        } else {
            return response()->json(['error' => 'Failed to update the request'], 500);
        }
    }

    public function cancelUserRequest(Request $request,$userbookingID)
    {
        $booking = DB::table('userbookings')->where('userbookingID', $userbookingID)->first();

        if (!$booking) {
            return response()->json(['error' => 'Booking ID not found'], 404);
        }

        $result = DB::table('userbookings')
        ->where('userbookingID', $userbookingID)
        ->update(['status' => 'cancelled']);

        if ($result) {
            return response()->json(['message' => 'Request Changed to inProgress successfully']);
        } else {
            return response()->json(['error' => 'Failed to update the request'], 500);
        }
    }

    public function completeUserBooking(Request $request,$userbookingID)
    {
        $booking = DB::table('userbookings')->where('userbookingID', $userbookingID)->first();

        if (!$booking) {
            return response()->json(['error' => 'Booking ID not found'], 404);
        }

        $result = DB::table('userbookings')
        ->where('userbookingID', $userbookingID)
        ->update(['status' => 'completed']);

        if ($result) {
            return response()->json(['message' => 'Request Changed to inProgress successfully']);
        } else {
            return response()->json(['error' => 'Failed to update the request'], 500);
        }
    }
}
