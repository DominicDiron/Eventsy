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
        Schema::create('plannerbookings', function (Blueprint $table) {
            $table->id('bookingID');
            $table->unsignedBigInteger('plannerID');
            $table->unsignedBigInteger('bookedPlannerID');
            $table->enum('status', ['pending', 'inProgress','completed','cancelled'])->default('pending');
            $table->foreign('plannerID')->references('plannerID')->on('planners');
            $table->foreign('bookedPlannerID')->references('plannerID')->on('planners');
            //$table->unique(['plannerID', 'bookedPlannerID']);
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
