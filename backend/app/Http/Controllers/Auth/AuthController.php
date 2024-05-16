<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\RegisterRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Planner;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|min:3',
            'contact'=>'required',
            'location'=>'required',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:3'
        ]);
        // $request->validated();
        if($request->userType == "user")
        {
            $userData = [
                'profileIMG' =>$request->profileIMG,
                'name' => $request->name,
                'contact' => $request->contact,
                'location' => $request->location,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ];
    
            $user = User::create($userData);
            $token = $user->createToken('eventsy')->plainTextToken;
    
            return response([
                'user' => $user,
                'token' => $token
            ],201);
        }
        elseif($request->userType == "planner")
        {
            $plannerData = [
                'profileIMG' =>$request->profileIMG,
                'name' => $request->name,
                'contact' => $request->contact,
                'location' => $request->location,
                'email' => $request->email,
                'image1'=>$request->image1,
                'image2'=>$request->image2,
                'image3'=>$request->image3,
                'image4'=>$request->image4,
                'description'=>$request->description,
                'services'=>$request->services,
                'password' => Hash::make($request->password),
            ];
    
            $planner = Planner::create($plannerData);
            $token = $planner->createToken('eventsy')->plainTextToken;
    
            return response([
                'user' => $planner,
                'token' => $token
            ],201);
        }
    }

    public function login(Request $request)
    {
        $request->validate([
            'email'=>'required|email',
            'password'=>'required|min:3'
        ]);
        
        if($request->userType == "User")
        {
            $user = User::where('email',$request->email)->first();
        
            if(!$user||!(Hash::check($request->password,$user->password)))
            {
                return response([
                    'message'=>'Invalid Credentials'
                ],422);
            }

            $token = $user->createToken('eventsy')->plainTextToken;
            return response([
                'user' => $user,
                'token' => $token
            ],200);
        }
        elseif($request->userType == "Planner")
        {
            $planner = Planner::where('email',$request->email)->first();
        
            if(!$planner||!(Hash::check($request->password,$planner->password)))
            {
                return response([
                    'message'=>'Invalid Credentials'
                ],422);
            }

            $token = $planner->createToken('eventsy')->plainTextToken;
                return response([
                'user' => $planner,
                'token' => $token
            ],200);
        }
        
    }
}
