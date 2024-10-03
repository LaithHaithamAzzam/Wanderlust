<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Trip;

class Type extends Model
{
    use HasFactory;

    protected $fillable=['type'];

    public function trips(){
        return $this->hasMany(Trip::class);
    }

    public function search(){
        return $this->hasMany(Search::class);
    }
}
