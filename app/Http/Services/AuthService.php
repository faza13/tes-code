<?php

namespace App\Http\Services;

use App\Models\Token;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Ramsey\Uuid\Uuid;

class AuthService
{
    public function login($username, $password)
    {
        $user = User::where('username', $username)->first();

        if($user){
            if(Hash::check($password, $user->password))
            {
                $user->token = (string) Uuid::uuid4();
                $user->save();
                return $user;

            }
        }

        throw new \Exception("username atau password salah");
    }
}
