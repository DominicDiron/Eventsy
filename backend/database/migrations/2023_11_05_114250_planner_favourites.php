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
        Schema::create('plannerfavourites', function (Blueprint $table) {
            $table->id('favouriteID');
            $table->unsignedBigInteger('plannerID');
            $table->unsignedBigInteger('favouritePlannerID');
            $table->foreign('plannerID')->references('plannerID')->on('planners');
            $table->foreign('favouritePlannerID')->references('plannerID')->on('planners');
            $table->unique(['plannerID', 'favouritePlannerID']);
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
        Schema::dropIfExists('plannerFavourites');
    }
};
