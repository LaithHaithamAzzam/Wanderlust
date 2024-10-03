<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Type;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('types', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string('type');
        });

        $types=[
            ['type'=>'Beaches'],
            ['type'=>'Cities'],
            ['type'=>'Desert'],
            ['type'=>'Lakes'],
            ['type'=>'Mountains'],
            ['type'=>'Tourist Attractions'],
        ];
        Type::insert($types);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('types');
    }
};
