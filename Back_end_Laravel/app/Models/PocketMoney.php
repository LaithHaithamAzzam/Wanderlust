<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PocketMoney extends Model
{
    use HasFactory;

    public function user(){
        return $this->belongsTo(User::class);
    }

    protected $fillable =['previous','current','latest charge', 'latest deduction'];

    public function deduct($amount){
        $deducted=[
            'latest deduction'=>$amount,
            'previous'=>$this->current,
            'current'=>$this->current-$amount
        ];
        return $this->update($deducted);
    }

    public function charge($validated){
        $money=null;
  
           $money=[ 'current'=>$this->current+$validated['amount'],
                    'previous'=>$this->current,
                    'latest charge'=>$validated['amount'],
        ];
           $this->update($money);  
           return response()->json(["current amount"=>$this->current],200); 
        
     }
}
