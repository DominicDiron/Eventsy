<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use DB;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //

        $user1 = User::create([
        'name'=>'Ajith',
        'location'=>'badulla',
        'password'=>Hash::make('12345'),
        'profileIMG'=>'https://picsum.photos/250?image=25',
        'contact'=>'+94762857565',
        'email'=>'ajith@gmail.com',

        ]);

        $user2 = User::create([
            'name'=>'Pradheepan',
            'location'=>'Trincomalee',
            'password'=>Hash::make('12345'),
            'profileIMG'=>'https://picsum.photos/250?image=26',
            'contact'=>'+94773915572',
            'email'=>'pradhee@gmail.com',
            ]);

        $user3 = User::create([
                'name'=>'Abishan',
                'location'=>'Nuwara Eliya',
                'password'=>Hash::make('12345'),
                'profileIMG'=>'https://picsum.photos/250?image=27',
                'contact'=>'+94767672875',
                'email'=>'abishan@gmail.com',
                ]);
        
        $user4 = User::create([
                'name'=>'Riffadh',
                'location'=>'Gampaha',
                'password'=>Hash::make('12345'),
                'profileIMG'=>'https://picsum.photos/250?image=28',
                'contact'=>'+94767013040',
                'email'=>'riffadh@gmail.com',
                ]);
    }
}
