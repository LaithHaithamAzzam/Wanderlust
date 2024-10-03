<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Auth;
use Firebase\JWT\JWT;
use Lcobucci\JWT\Configuration;
use App\Models\Trip;
use App\Models\Service;
use App\Models\PocketMoney;
use Firebase\JWT\Key;
use Firebase\JWT\ExpiredException;
use Firebase\JWT\SignatureInvalidException;
use Exception;
use App\Models\Type;

class AdminController extends Controller
{
 
    public function CreateTrip(Request $request){
       
       try{ $validatedData= $request->validate([
            'type'=> 'required|string|exists:types,type',
            'Season_Type'=>'required|string',
            'Name_trip'=>'required|string',
            'Sallary'=>'required|integer',
            //'Start_date'=>'date|date_format:Y-m-d|required',
            'Start_date'=>'date|required',
            'End_date'=>'date|required',
            'Day_count'=>'integer|required',
            'End_date_booking'=>'date|required',
            'Activitys'=>'required|array',
            //'Activitys.*'=>'string',
            'Services'=>'required|array',
            //'Services.*'=>'exists:services,id',
       ]);
       } catch(ValidationException $e){
        return response()->json(['error'=>$e->errors(),], 210);
       }

      $user=User::find(AdminController::decodeToken($request->bearerToken()));
      
      try {
         $type=Type::where('type',$validatedData['type'])->first();
         $trip=Trip::create([
        'type_id'=>$type->id,
        'season'=>$request->input('Season_Type'),
        'trip_name'=>$request->input('Name_trip'),
        'price_per_person'=>$request->input('Sallary'),
        'start_date'=>$request->input('Start_date'),
        'end_date'=>$request->input('End_date'),
        'days_count'=>$request->input('Day_count'),
        'booking_end_date'=>$request->input('End_date_booking'),
        //'activities'=>$request->input('Activitys'),
        //'services'=>$request->input('Services'),
       ]);

       //$services=$this->convertToIntArray($validatedData['Services']);
       $services=$this->createServicesArray($validatedData['Services']);
      // $activities
      // $services=$validatedData['Services'];
       $activities=$this->createActivitiesArray($validatedData['Activitys']);
       $trip->services()->createMany($services);
       $trip->activities()->createMany($activities);
     
    }catch(Exception $e){
        return response()->json(['error'=>$e->getMessage()],210);
    }
   

       return response()->json(['id'=>$trip->trip_id],200);
    }

    public function convertToIntArray($data){
      $stringArray=explode(',',$data);
      return array_map('intval',$stringArray);
    }

    public function CreateServicesArray($array){
      return $arrays=array_map(function ($item){
         return ['service'=>trim($item)];
      }, $array);
   }

      public function CreateActivitiesArray($array){
         return $arrays=array_map(function ($item){
            return ['activity'=>trim($item)];
         }, $array);
    }



    public function ChargeMoney(Request $request){
      try{
         $validated=$request->validate([
            'amount'=>'integer|required',
            'user'=>'required|string|exists:users,username'
         ]);

      }catch(validationException $e){
         return response()->json(['error'=>$e->errors()],210);
      }
      $money=null;
      $user=User::where('username',$validated['user'])->first();

      if(User::isAdmin($user->id))
            return response()->json(['error'=>"The entered user shouldn't be an admin"],210);

      $pocketMoney=PocketMoney::where('user_id',$user->id)->first();
         $money=[ 'current'=>$pocketMoney->current+$validated['amount'],
                  'previous'=>$pocketMoney->current,
                  'latest charge'=>$validated['amount'],
      ];
         $user->pocketMoney()->update($money);  
         return response()->json(["current amount"=>$user->PocketMoney->current],200);
      
      
   }
     


   public function EditTrip(Request $request){
      try{ $validatedData= $request->validate([
         'id'=>'required|integer|exists:trips,trip_id',
         'type_id'=> 'sometimes|string|exists:types,type',
         'season'=>'sometimes|string',
         'trip_name'=>'sometimes|string',
         'price_per_person'=>'sometimes|integer',
         'start_date'=>'sometimes|date',
         'end_date'=>'sometimes|date',
         'days_count'=>'sometimes|integer|required',
         'booking_end_date'=>'sometimes|date',
         'activities'=>'sometimes|array',
         //'Activitys.*'=>'string',
         'services'=>'sometimes|array',
         //'Services.*'=>'exists:services,id',
    ]);
    } catch(ValidationException $e){
     return response()->json(['error'=>$e->errors(),], 210);
    }
    if($request->has('type_id')){
      $type=Type::where('type',$validatedData['type_id'])->first();
      $validatedData['type_id']=$type->id;
    }
    $trip=Trip::find($validatedData['id']);
    $trip->update($validatedData);

    if($request->has('services')){
      $trip->services()->delete();
      $services=$this->createServicesArray($validatedData['services']);
      $trip->services()->createMany($services);
    }
    
    if($request->has('activities')){
      $trip->activities()->delete();
      $activities=$this->createActivitiesArray($validatedData['activities']);
      $trip->activities()->createMany($activities);
    }
    
    return response()->json(['id'=>$trip->trip_id],200);

   }

   public static function decodeToken($token){
      $key=env('JWT_SECRET');
      
      if(!$token)
      return response()->json(['Error'=>'Unauthorised'],401);
   
      try{
       //$payLoad=JWTAuth::parseToken()->getPayLoad();
       $decoded=JWT::decode($token, new Key($key, 'HS256'));
      } catch(ExpiredException $e){
       return response()->json(['Error'=>$e->getMessage()],401);
      }catch(SignatureInvalidException $e){
       return response()->json(['Error'=>$e->getMessage()],401);
      }catch(Exception $e){
       return response()->json(['Error'=>$e->getMessage()],401);
      }

      return $decoded->id;
   }

   public function DeleteTrip(Request $request){
      try{
         $validated=$request->validate([
         'trip_id'=>'required|exists:trips,trip_id',
      ]);
   }catch(ValidationException $e){
      return response()->json(['error'=>$e->errors(),], 210);
      }
      $trip=Trip::find($validated['trip_id']);
      $trip->delete();
      return response()->json(["trip deleted"],200);
   }

   public function AddPhoto(Request $request){
      try{
         $validated=$request->validate([
            'trip_id'=>'required|exists:trips,trip_id',
            'photo'=>'required',
         ]);
      }catch(ValidationException $e){
         return response()->json(['error'=>$e->errors(),], 210);
      }
    
      // تحويل البيانات الثنائية إلى صورة
       $imageData = $request->photo;
       $imageData = base64_decode($imageData);
      // حفظ الصورة في ملف
      $photopath=time().'.jpg';
      file_put_contents(public_path('images').'/'.$photopath, $imageData);
    
      $trip=Trip::find($validated['trip_id']);
      $trip->update([
         'photo'=>$photopath,
      ]);
      return response()->json(["photopath"=>$photopath],200);
    }
    
    

   public function ExpiryDelete(Request $request){
      try{
         $validated=$request->validate([
            'end_date'=>'required|date',
         ]);
      }catch(ValidationException $e){
         return response()->json(['error'=>$e->errors()],210);
      }
      $trips=Trip::where('end_date',$validated['end_date'])->get();
      if($trips->isNotEmpty())
         $trips->each->delete();
      else return response()->json(["No trips found"],210);
      return response()->json(['deleted'],200);
   }

}
