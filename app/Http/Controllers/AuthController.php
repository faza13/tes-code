<?php

namespace App\Http\Controllers;

use App\Http\Services\AuthService;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function login(Request $request, AuthService $authService)
    {
        try{
            $this->validate($request, [
                'username' => "required",
                'password' => "required"
            ]);
        }
        catch (ValidationException $e) {
            return response([
                'success' => false,
                'messages' => $e->errors()
            ], 422);
        }

        try {
            $user = $authService->login($request->get('username'), $request->get('password'));
            return response([
                'success' => false,
                'message' => 'Login berhasil',
                'data' => [
                    'user' => $user,
                ]
            ]);
        }
        catch (\Exception $e)
        {
            return response([
                'success' => false,
                'message' => $e->getMessage()
            ], 422);
        }
    }
}
