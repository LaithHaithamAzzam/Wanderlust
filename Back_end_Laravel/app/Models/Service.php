<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    public function trip(){
        return $this->belongsTo(Trip::class, 'trip_id', 'trip_id');
    }

    protected $fillable = ['service'];
}