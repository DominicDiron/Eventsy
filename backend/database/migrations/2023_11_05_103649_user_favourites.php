<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('userfavourites', function (Blueprint $table) {
            $table->id('favouriteID');
            $table->unsignedBigInteger('userID');
            $table->unsignedBigInteger('favouritePlannerID');
            $table->foreign('userID')->references('userID')->on('users');
            $table->foreign('favouritePlannerID')->references('plannerID')->on('planners');
            $table->unique(['userID', 'favouritePlannerID']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
};
