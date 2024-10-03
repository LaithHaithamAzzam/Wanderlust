<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\Pivot;

class Booking extends Pivot
{
    //
    protected $table='bookings';
    protected $fillable=[
        'payment',
        'person_count',
        'trip_id',
        'user_id',
    ];
    
   
}
