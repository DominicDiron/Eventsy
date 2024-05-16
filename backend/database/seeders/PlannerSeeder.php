<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Planner;
use Illuminate\Support\Facades\Hash;
use DB;

class PlannerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //

        $planner1 = Planner::create([
        'name'=>'Dominic Diron',
        'location'=>'Hatton',
        'password'=>Hash::make('12345'),
        'profileIMG'=>'https://picsum.photos/250?image=29',
        'image1'=>'https://picsum.photos/250?image=20',
        'image2'=>'https://picsum.photos/250?image=21',
        'image3'=>'https://media.istockphoto.com/id/186565659/photo/prepared-birthday-table.jpg?s=612x612&w=0&k=20&c=YJat8czNKq_memVNdasRm7QkmFV5kZek8MuNvJfL2oA=',
        'image4'=>'https://media.istockphoto.com/id/186565659/photo/prepared-birthday-table.jpg?s=612x612&w=0&k=20&c=YJat8czNKq_memVNdasRm7QkmFV5kZek8MuNvJfL2oA=',
        'contact'=>'+9477896078',
        'email'=>'diron@gmail.com',
        'description'=>'2019/CSC/007',
        'services' => 'Event booking,Event planning,Birthday decorations',
        ]);

        $planner2 = Planner::create([
            'name'=>'Niroshan',
            'location'=>'Colombo',
            'password'=>Hash::make('12345'),
            'profileIMG'=>'https://picsum.photos/250?image=1',
            'image1'=>'https://picsum.photos/250?image=2',
            'image2'=>'https://picsum.photos/250?image=3',
            'image3'=>'https://picsum.photos/250?image=4',
            'image4'=>'https://picsum.photos/250?image=5',
            'contact'=>'+94778819120',
            'email'=>'niro@gmail.com',
            'description'=>'2019/CSC/008',
            'services' => 'Hall booking,Event planning,Hall decorations',
            ]);

            $planner3 = Planner::create([
                'name'=>'Rashmika',
                'location'=>'Kandy',
                'password'=>Hash::make('12345'),
                'profileIMG'=>'https://picsum.photos/250?image=7',
                'image1'=>'https://picsum.photos/250?image=28',
                'image2'=>'https://picsum.photos/250?image=9',
                'image3'=>'https://picsum.photos/250?image=10',
                'image4'=>'https://picsum.photos/250?image=11',
                'contact'=>'+94766573972',
                'email'=>'rash@gmail.com',
                'description'=>'2019/CSC/009',
                'services' => 'Transport,Venue booking',
                ]);
                
                $planner4 = Planner::create([
                    'name'=>'Senal',
                    'location'=>'Anuradhapura',
                    'password'=>Hash::make('12345'),
                    'profileIMG'=>'https://picsum.photos/250?image=13',
                    'image1'=>'https://picsum.photos/250?image=14',
                    'image2'=>'https://picsum.photos/250?image=15',
                    'image3'=>'https://picsum.photos/250?image=16',
                    'image4'=>'https://picsum.photos/250?image=17',
                    'contact'=>'+94752484352',
                    'email'=>'senal@gmail.com',
                    'description'=>'2019/CSC/010',
                    'services' => 'Hall booking,Event planning,Hall decorations',
                    ]);
                    
            $planner5 = Planner::create([
                    'name'=>'Athithan',
                    'location'=>'Jaffna',
                    'password'=>Hash::make('12345'),
                    'profileIMG'=>'https://picsum.photos/250?image=19',
                    'image1'=>'https://picsum.photos/250?image=20',
                    'image2'=>'https://picsum.photos/250?image=21',
                    'image3'=>'https://picsum.photos/250?image=22',
                    'image4'=>'https://picsum.photos/250?image=23',
                    'contact'=>'+94762600410',
                    'email'=>'athi@gmail.com',
                    'description'=>'2019/CSC/006',
                    'services' => 'Hall booking,Event planning,Hall decorations',
                    ]);
            
        //$planner1->friends()->attach($planner2);
        //$planner2->friends()->attach($planner1);

    }
}
