<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Notification extends Model
{
    use HasFactory;
    protected $fillable=[
    'trip_id',
    'start_date',
    'person_count',
    'trip_name'
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }
    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d');
    }
    protected $dates=['start_date'];
    protected $casts=['start-date'=>'data'];
}
