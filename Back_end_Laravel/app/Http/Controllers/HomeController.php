<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Http\Controllers\AdminController;
use App\Models\User;
use App\Models\Trip;
use Illuminate\Validation\ValidationException;
use App\Models\Type;
use Illuminate\Support\Facades\Auth;
use App\Models\Booking;
use App\Models\PocketMoney;
use Illuminate\Support\Facades\DB;
use App\Models\Favourite;
use App\Models\Notification;
use App\Models\Search;
use Carbon\Carbon;

class HomeController extends Controller
{
    //

    public function home(){
        return response()->json([],200);
    }

 
    public function ShowWallet(Request $request){

        $userId=AdminController::decodeToken($request->bearerToken());
        if(User::isAdmin($userId))
            return response()->json([],401);

        $user=User::find($userId);
        return response()->json(['Money'=>$user->pocketMoney->current], 200);
     }

     public function ShowTrips(Request $request){
        $trips=Trip::all();
        if(count($trips)==0)
        return response()->json(['No trips found']);

        $data=$this->ExtractTrips($trips);
        return response()->json(["data"=>$data], 200);
    }

    public function ExpandTrip(Request $request){
        try{
            $validated=$request->validate([
            'trip_id'=>'required|exists:trips,trip_id',
            ]);
    }catch(ValidationException $e){
        return response()->json(['error'=>$e->errors()],210);
    }   $user_id=AdminController::decodeToken($request->bearerToken());
        $user=User::find($user_id);
       
        $trip=Trip::find($validated['trip_id']);
        $type=Type::find($trip->type_id);
        $person_count=$user->getCount($trip);
        $isBooking=null;
        $isFavourite=$user->isFavourite($trip);
        if($person_count>0)
            $isBooking=true;
        else
            $isBooking=false;
        /**/
        $services=$trip->services->all();  //These two lines are needed to get the services and activities inside the trip instance
        $activities=$trip->activities->all();  //These two lines are needed to get the services and activities inside the trip instance
        if($user->role=='admin')
            return response()->json(['type'=>$type->type,'trip'=>$trip],200);
        else
            return response()->json(['isbooking'=>$isBooking, 'isFavourite'=>$isFavourite, 'person_count'=>$person_count, 'type'=>$type->type,'trip'=>$trip],200);
    }

   

        public function ShowType(Request $request){
            try{ 
                $validated=$request->validate([
                    'type'=>'string|required|exists:types,type',
                ]);

            }catch(ValidationException $e){
                return response()->json(['error'=>$e->errors()],210);
            }
            
            $type=Type::where('type', $validated['type'])->first();
            $trips=$this->ExtractTrips($type->trips->all());
            if(count($trips)==0)
            return response()->json(['No trips found']);
        
            return response()->json(['data'=>$trips], 200);
        }

        public function ExtractTrips($trips){
            $data=[];
            for($i=0; $i<count($trips);$i++){
                $data[$i]=[
                    'trip_id'=>$trips[$i]['trip_id'],
                    'name'=>$trips[$i]['trip_name'],
                    'type'=>$trips[$i]['type']['type'],
                    'days_count'=>$trips[$i]['days_count'],
                    'booking_end_date'=>Carbon::parse($trips[$i]['booking_end_date'])->format('Y-m-d'),
                    'photopath'=>$trips[$i]['photo'],
                   
                ];
            }
            return $data;
        }

        public function book(Request $request){
            try{
                $validated=$request->validate([
                    'trip_id'=>'required|exists:trips,trip_id',
                    'person_count'=>'integer|required'
                ]);
            }catch(ValidationException $e){
                return response()->json(['error'=>$e->errors()],210);
            }
            $user_id=AdminController::decodeToken($request->bearerToken());
            $trip=Trip::find($validated['trip_id']);
            $user=User::find($user_id);
            $payment=$validated['person_count']*$trip->price_per_person;
            if(User::isAdmin($user_id))
                return repsonse()->json(['message'=>'admin user', 210]);
            if(!$trip->booking_end_date->isFuture())
                return response()->json(['message'=>'too late to book'],210);
            if($user->pocketMoney->current<$payment)
                return response()->json(['message'=>"insufficient fund"],210);
            $booking=Booking::create([
                'trip_id'=>$validated['trip_id'],
                'user_id'=>$user_id,
                'payment'=>$payment,
                'person_count'=>$validated['person_count'],
            ]);
            $user->PocketMoney->deduct($payment);

            $notification=$user->notifications()->create([
                'trip_id'=>$validated['trip_id'],
                'start_date'=>$trip->start_date,
                'person_count'=>$booking->person_count,
                'trip_name'=>$trip->trip_name,
            ]);
            return response()->json(['message'=>"booking done",'amount taken'=>$payment,'your balance'=>$user->PocketMoney->current, 'notification'=>$notification], 200);

        }


        public function DeleteNotifications(Request $request){
            try{
            $user_id=AdminController::decodeToken($request->bearerToken());
            $user=User::find($user_id);
            $user->notifications()->delete();
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()],210);
        }
            return response()->json(["Notifications deleted"],200);
        }

        public function ShowNotifications(Request $request){
            try{$user_id=AdminController::decodeToken($request->bearerToken());
            $user=User::find($user_id);
            $notifications=$user->notifications->all();
            if(!$notifications)
                return response()->json(["No notifications"],200);
            }catch(Exception $e)
            {return response()->json(['error'=>$e->getMessage()],210);}

            return response()->json(['notifications'=>$notifications],200);
        }

        

        public function unbook(Request $request){
            try{
                $validated=$request->validate([
                    'trip_id'=>'required|exists:trips,trip_id',
                ]);
            }catch(ValidationException $e){
                return response()->json(['error'=>$e->errors()],210);
            }
            $notification=Notification::where('trip_id',$validated['trip_id'])->first();
            $user_id=$notification->user_id;
            $trip=Trip::find($validated['trip_id']);
            $user=User::find($user_id);
            if($user->role=='admin')
                return repsonse()->json(['message'=>'admin user', 210]);
            $booking=Booking::where('trip_id',$validated['trip_id'])->first();
            if(!$booking)
                return response()->json(["message"=>"booking doesn't exist"],210);
            if(!$trip->start_date->isFuture())
                return response()->json(["Too late to cancel booking"], 210);
            $payment=$booking->payment;
            $data=['user'=>$user->username,'amount'=>$payment];
            $user->PocketMoney->charge($data);
            $booking->delete();
            $notification->delete();
            
            return response()->json(['message'=>"booking deleted",'amount returned'=>$payment,'your balance'=>$user->PocketMoney->current], 200);
        }

      

         public function EditBooking(Request $request){
            try{
                $validated=$request->validate([
                    'trip_id'=>'required|exists:trips,trip_id',
                    'person_count'=>'required|integer',
                ]);
            }catch(ValidationException $e){
                return response()->json(['error'=>$e->errors()],210);
            }
            $trip=Trip::find($validated['trip_id']);
            if(!$trip->booking_end_date->isFuture())
                 return response()->json(['message'=>'too late to edit booking'],210);
            $user_id=AdminController::decodeToken($request->bearerToken());
            $user=User::find($user_id);
            $booking=Booking::where('trip_id',$validated['trip_id'])->first();
            $payment=null;
            $notification=Notification::where('trip_id',$validated['trip_id'])->first();
            $notification->person_count=$validated['person_count'];
            $notification->save();
            if($validated['person_count']>$booking->person_count){
                $payment=($validated['person_count']-$booking->person_count)*$trip->price_per_person;
                if($user->pocketMoney->current<$payment)
                    return response()->json(['message'=>"insufficient fund"],210);
                $user->PocketMoney->deduct($payment);
                $data=[
                    'person_count'=>$validated['person_count'],
                    'payment'=>$payment+$booking->payment,
                ];
                $booking->update($data);
                return response()->json(['message'=>"booking updated",'amount taken'=>$payment,'your balance'=>$user->PocketMoney->current,'notification'=>$notification], 200);
            }
            else if($validated['person_count']==$booking->person_count)
                return response()->json(['No edits done'],210);
            else if($validated['person_count']==0){
                $notification->delete();
                return response()->json(['Would you like to delete your booking?'],200);
            }
            else {
                $refund=($booking->person_count-$validated['person_count'])*$trip->price_per_person;
                $user->PocketMoney->charge(['amount'=>$refund]);
                $data=[
                    'person_count'=>$validated['person_count'],
                    'payment'=>$booking->payment-$refund,
                ];
                $booking->update($data);
                return response()->json(['message'=>"booking edited",'amount returned'=>$refund,'your balance'=>$user->PocketMoney->current, 'notification'=>$notification], 200);
            }
       
         }


         public function testFunction(Request $request){
            Booking::truncate();
         }

         public function AddToFavourite(Request $request){
            try{
                $validated=$request->validate([
                    'trip_id'=>'required|exists:trips,trip_id',
                ]);
            }catch(ValidationException $e){
                return response()->json(['error'=>$e->errors()],210);
            }
            $user_id=AdminController::decodeToken($request->bearerToken());
            $user=User::find($user_id);
            if($user->role=='admin')
                    return response()->json(["Admins cannot have favourites"], 210);
            $favourite=Favourite::create([
                'trip_id'=>$validated['trip_id'],
                'user_id'=>$user_id,
            ]);
            return response()->json(["trip added to favourites"],200);

         }

         public function GetFavourites(Request $request){

            $user_id=AdminController::decodeToken($request->bearerToken());
            $user=User::find($user_id);
            if(!$user->FavouriteTrips->all())
                return response()->json(["Favourite list empty"],200);
            $trips=$this->ExtractTrips($user->FavouriteTrips);

            return response()->json(['favourites'=>$trips],200);
         }

         public function RemoveFavourite(Request $request){
            try{
                $validated=$request->validate([
                    'trip_id'=>'required|exists:trips,trip_id',
                ]);
            }catch(ValidationException $e){
                return response()->json(['error'=>$e->errors()],210);
            }
            $user_id=AdminController::decodeToken($request->bearerToken());
            $user=User::find($user_id);
            $trip=$user->FavouriteTrips()->find($validated['trip_id']);
            if(!$trip)
                return response()->json(['trip is not in your favourites'],210);
            $user->FavouriteTrips()->detach($trip->trip_id);
            return response()->json(["removed"],200);

         }

         public function search(Request $request){
                try{
                    $validated=$request->validate([
                        'Startdate'=>'date|sometimes|exists:trips,start_date',
                        'Enddate'=>'date|sometimes|exists:trips,end_date',
                        'Daycount'=>'integer|sometimes|exists:trips,days_count',
                        'Type'=>'string|sometimes|exists:types,type',
                        'Season'=>'string|sometimes|exists:trips,season',
                        'price'=>'integer|sometimes|exists:trips,price_per_person',
                        'booking_end_date'=>'sometimes|date|exists:trips,booking_end_date',
                        'trip_name'=>'sometimes|string|exists:trips,trip_name'
                    ]);
                }catch(ValidationException $e){
                    return response()->json(['Not found'],210);
                }
                
                if($request->has('Startdate')&&Trip::where('start_date',$validated['Startdate'])->get()->isNotEmpty()){
                        $trips=Trip::where('start_date',$validated['Startdate'])->get();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                }if($request->has('Enddate')){
                    if(!Search::count()==0){
                        if(Search::where('end_date',$validated['Enddate'])->get()->isNotEmpty()){
                        $trips=Search::where('end_date',$validated['Enddate'])->get();
                        Search::truncate();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                        }else{
                            Search::truncate();
                            return response()->json(["Not found"],200);
                        }

                    }else if(Trip::where('end_date',$validated['Enddate'])->get()->isNotEmpty()){
                        $trips=Trip::where('end_date',$validated['Enddate'])->get();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                    }
                }if($request->has('Daycount')){
                    if(!Search::count()==0){
                        if(Search::where('days_count',$validated['Daycount'])->get()->isNotEmpty()){
                        $trips=Search::where('days_count',$validated['Daycount'])->get();
                        Search::truncate();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                        }else{
                            Search::truncate();
                            return response()->json(["Not found"],200);
                        }

                    }else if(Trip::where('days_count',$validated['Daycount'])->get()->isNotEmpty()){
                        $trips=Trip::where('days_count',$validated['Daycount'])->get();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                    }
                }if($request->has('Season')){
                    if(Search::count()!=0){
                        if(Search::where('season',$validated['Season'])->get()->isNotEmpty()){
                        $trips=Search::where('season',$validated['Season'])->get();
                        Search::truncate();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                        }else{
                            Search::truncate();
                            return response()->json(["Not found"],200);
                        }

                    }else if(Trip::where('season',$validated['Season'])->get()->isNotEmpty()){
                        $trips=Trip::where('season',$validated['Season'])->get();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                    }
                }if($request->has('price')){
                    if(!Search::count()==0){
                        if(Search::where('price_per_person',$validated['price'])->get()->isNotEmpty()){
                        $trips=Search::where('price_per_person',$validated['price'])->get();
                        Search::truncate();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                        }else{
                            Search::truncate();
                            return response()->json(["Not found"],200);
                        }

                    }else if(Trip::where('price_per_person',$validated['price'])->get()->isNotEmpty()){
                        $trips=Trip::where('price_per_person',$validated['price'])->get();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                    }
                }if($request->has('Type')){
                        $type_id=Type::where('type',$validated['Type'])->first()->id;
                        if(!Search::count()==0){
                            if(Search::where('type_id',$type_id)->get()->isNotEmpty()){
                            $trips=Search::where('type_id',$type_id)->get();
                            Search::truncate();
                            $trips=$this->CastDates($trips);
                            Search::insert($trips);
                            }else{
                                Search::truncate();
                                return response()->json(["Not found"],200);
                            }
                            
                        }else if(Trip::where('type_id',$type_id)->get()->isNotEmpty()){
                            $trips=Trip::where('type_id',$type_id)->get();
                            $trips=$this->CastDates($trips);
                            Search::insert($trips);
                        }
                }if($request->has('trip_name')){
                    if(!Search::count()==0){
                        if(Search::where('trip_name',$validated['trip_name'])->get()->isNotEmpty()){
                        $trips=Search::where('trip_name',$validated['trip_name'])->get();
                        Search::truncate();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                        }else{
                            Search::truncate();
                            return response()->json(["Not found"],200);
                        }

                    }else if(Trip::where('trip_name',$validated['trip_name'])->get()->isNotEmpty()){
                        $trips=Trip::where('trip_name',$validated['trip_name'])->get();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                    }
                }if($request->has('booking_end_date')){
                    if(!Search::count()==0){
                        if(Search::where('booking_end_date',$validated['booking_end_date'])->get()->isNotEmpty()){
                        $trips=Search::where('booking_end_date',$validated['booking_end_date'])->get();
                        Search::truncate();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                        }else{
                            Search::truncate();
                            return response()->json(["Not found"],200);
                        }

                    }else if(Trip::where('booking_end_date',$validated['booking_end_date'])->get()->isNotEmpty()){
                        $trips=Trip::where('booking_end_date',$validated['booking_end_date'])->get();
                        $trips=$this->CastDates($trips);
                        Search::insert($trips);
                    }
                }
                if(Search::get()->isEmpty())
                    return response()->json(["Not found"],200);
                $original=[];
                $OriginalTrip=null;
                foreach ($trips as $trip){
                    $originalTrip=Trip::find($trip['trip_id']);
                    array_push($original,$originalTrip);
                }
                $original=$this->ExtractTrips($original);
                Search::truncate();
                return response()->json(['data'=>$original],200);
         }

         public function CastDates($records){
            $data=[];
            for($i=0;$i<count($records);$i++) {
                // Format the dates to Y-m-d H:i:s
                $booking_end_date = Carbon::parse($records[$i]->booking_end_date)->format('Y-m-d H:i:s');
                $created_at = Carbon::parse($records[$i]->created_at)->format('Y-m-d H:i:s');
                $end_date = Carbon::parse($records[$i]->end_date)->format('Y-m-d H:i:s');
                $start_date = Carbon::parse($records[$i]->start_date)->format('Y-m-d H:i:s');
                $updated_at = Carbon::parse($records[$i]->updated_at)->format('Y-m-d H:i:s');
            
                // Prepare the data for insertion
                $data[$i]= [
                    'booking_end_date' => $booking_end_date,
                    'created_at' => $created_at,
                    'days_count' => $records[$i]->days_count,
                    'end_date' => $end_date,
                    'photo' => $records[$i]->photo,
                    'price_per_person' => $records[$i]->price_per_person,
                    'season' => $records[$i]->season,
                    'start_date' => $start_date,
                    'trip_id' => $records[$i]->trip_id,
                    'trip_name' => $records[$i]->trip_name,
                    'type_id' => $records[$i]->type_id,
                    'updated_at' => $updated_at
                ];
            
                // Insert the data into the second table
            }
            return $data;
         }

         

       
}
