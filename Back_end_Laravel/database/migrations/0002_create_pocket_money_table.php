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
        Schema::create('pocket_money', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->integer('current');
            $table->integer('previous');
            $table->integer('latest charge');
            $table->integer('latest deduction')->nullable();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pocket_money');
    }
};
