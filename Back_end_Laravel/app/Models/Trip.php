<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Trip extends Model
{
    use HasFactory;
    protected $primaryKey= 'trip_id';

   public function services(){
        return $this->hasMany(Service::class, 'trip_id','trip_id');
    }

    public function activities(){
        return $this->hasMany(Activity::class, 'trip_id', 'trip_id');
    }

    public function users(){
        return $this->belongsToMany(User::class, 'bookings', 'trip_id', 'user_id')->using(Booking::class)
                    ->as('bookingsPivot')
                    ->withPivot('payment', 'person_count')
                    ->withTimestamps();
    }
    public function userFavourites(){
        return $this->belongsToMany(User::class, 'favourites', 'trip_id', 'user_id')->using(Favourite::class)
                    ->as('favouritesPivot')            
                    ->withTimestamps();
    }

    public function type(){
        return $this->belongsTo(Type::class);
    }

    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d');
    }

    protected $fillable = [
        'photo',
        'trip_name',
        'type',
        'price_per_person',
        'start_date',
        'end_date',
        'days_count',
        'booking_end_date',
        'season',
        'type_id'
    ];
    protected $dates=[
        'booking_end_date',
        'start_date',
        'end_date',
        'updated_at',
        'created_at',
    ];
    protected $casts=[
        'booking_end_date' => 'date',
        'start_date'=>'date',
        'end_date'=>'date',
        'updated_at'=>'date',
        'created_at'=>'date'
    ];

    

   

    
}
