<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('searches', function (Blueprint $table) {
            $table->id('trip_id');
            $table->timestamps();
            $table->string('photo')->nullable();
            $table->string('season');
            $table->string('trip_name');
            $table->double('price_per_person');
            $table->date('start_date');
            $table->date('end_date');
            $table->integer('days_count');
            $table->date('booking_end_date');
            $table->foreignId('type_id')->constrained()->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('searches');
    }
};
