<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Relations\Pivot;

class Favourite extends Pivot
{
    //
    protected $table='favourites';
    protected $fillable=['trip_id','user_id'];
}
