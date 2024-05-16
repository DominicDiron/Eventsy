<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class Planner extends Model
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $primaryKey = 'plannerID';


    protected $fillable = [
        'plannerID',
        'name',
        'location',
        'password',
        'profileIMG',
        'image1',
        'image2',
        'image3',
        'image4',
        'contact',
        'email',
        'description',
        'services'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function favourites()
    {
        return $this->belongsToMany(Planner::class, 'plannerfavourites', 'plannerID', 'favouritePlannerID',); // Correct line

    }
    public function plannerbookings()
    {
        return $this->belongsToMany(Planner::class, 'plannerbookings', 'plannerID', 'bookedPlannerID',); // Correct line

    }
}
