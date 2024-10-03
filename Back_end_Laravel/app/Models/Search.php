<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DateTimeInterface;

class Search extends Model
{
    use HasFactory;
    public function type(){
        return $this->belongsTo(Type::class);
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

    protected function serializeDate(DateTimeInterface $date)
    {
        return $date->format('Y-m-d');
    }

    protected $primaryKey='trip_id';
}
