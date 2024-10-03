<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
 //

class User extends Authenticatable 
{
    use HasFactory, Notifiable;


    public static function isAdmin($id){
        $user=User::find($id);
        return $user->role==='admin';
    }

    public function pocketMoney(){
        return $this->hasOne(PocketMoney::class);
    }

    public function trips(){
        return $this->belongsToMany(Trip::class, 'bookings', 'user_id', 'trip_id')->using(Booking::class)
                    ->as('bookingsPivot')
                    ->withPivot('payment', 'person_count')
                    ->withTimestamps();
    }

    public function FavouriteTrips(){
        return $this->belongsToMany(Trip::class, 'favourites', 'user_id', 'trip_id')->using(Favourite::class)
                    ->as('favouritesPivot')            
                    ->withTimestamps();
    }

    public function notifications(){
        return $this->hasMany(Notification::class);
    }

    public function getCount($trip){
        $tripR=$this->trips()->find($trip->trip_id);
        if($tripR)
             return $tripR->bookingsPivot->person_count;
        return 0; 
     }
     public function isFavourite($trip){
        if($this->FavouriteTrips()->find($trip->trip_id))
            return true;
        else return false;
     }

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'username',
        'password',
        'role',
        'photo',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
}
