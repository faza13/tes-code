<?php

namespace App\Http\Controllers;

use App\Http\Services\AuthService;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class UserController extends Controller
{
    protected function ruleStore()
    {
        return [
            'name' => 'required',
            'username' => 'required',
            'password' => 'required',
            'id_no' => 'required|unique:users,id_no'
        ];
    }

    public function store(Request $request)
    {
        try{
            $this->validate($request, $this->ruleStore());
        }
        catch (ValidationException $e) {
            return response([
                'success' => false,
                'messages' => $e->errors()
            ], 422);
        }
        $name = $request->get('name');
        $username = $request->get('username');
        $password = $request->get('password');
        $idNo = $request->get('id_no');
        $role = $request->get('role');

        $user = new User;
        $user->name = $name;
        $user->id_no = $idNo;
        $user->username = $username;
        $user->password = Hash::make($password);
        $user->role = $role;

        $user->save();

        return response([
            'success' => true,
            'data' => [
                'user' => $user
            ]
        ]);
    }
}
