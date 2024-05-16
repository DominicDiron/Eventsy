<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $primaryKey = 'userID';
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'userID',
        'name',
        'location',
        'password',
        'profileIMG',
        'contact',
        'email',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
    public function userFavourites()
    {
        return $this->belongsToMany(Planner::class, 'userfavourites', 'userID', 'favouritePlannerID',); // Correct line

    }
    public function userbookings()
    {
        return $this->belongsToMany(Planner::class, 'userbookings', 'userID', 'bookedPlannerID',); // Correct line

    }
}
