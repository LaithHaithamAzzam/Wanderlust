<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Firebase\JWT\ExpiredException;
use Firebase\JWT\SignatureInvalidException;
use Exception;

class Admin
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
       $token=$request->bearerToken();
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
       
       if(!User::isAdmin($decoded->id))
            return response()->json(['Error'=>'Unauthorised admin access'], 401);

        return $next($request);
    }
}
