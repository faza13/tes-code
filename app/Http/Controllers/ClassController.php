<?php

namespace App\Http\Controllers;

use App\Enums\Role;
use App\Http\resources\ClassResource;
use App\Http\Services\AuthService;
use App\Http\Services\SlotService;
use App\Models\Classroom;
use App\Models\Slot;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class ClassController extends Controller
{
    private $rowStart = 1;
    private $columnStart = 'A';

    public function rulesCheckInOut()
    {
        return [
            'id_no' => 'required',
            'class_id' => 'required|integer',
        ];
    }

    public function rulesStore()
    {
        return [
            'x' => 'required|integer',
            'y' => 'required|integer',
        ];
    }

    public function store(Request $request)
    {
        try {
            $this->validate($request, $this->rulesStore());
        }
        catch (ValidationException $e) {
            return response([
                'success' => false,
                'messages' => $e->errors()
            ]);
        }

        $rows = $request->get('x');
        $columns = $request->get('y');
        $totalSlot = ($rows*$columns);

        $class = new Classroom();
        $class->rows = $rows;
        $class->columns = $columns;
        $class->total_slots = $totalSlot;
        $class->save();

        $slot = new Slot();
        $slot->seat = 'teacher';
        $slot->class_id = $class->id;
        $slot->save();

        for($this->rowStart; $this->rowStart <= $rows; $this->rowStart++)
        {
            $columStart= $this->columnStart;
            for($i=0;$i<$columns; $i++)
            {
                $slot = new Slot();
                $slot->seat = $this->rowStart . $columStart;
                $slot->class_id = $class->id;
                $columStart++;
                $slot->save();
            }
        }
        $class->load('slots');
        return response([
            'success' => true,
            'data' => [
                'class' => $class
            ]
        ]);
    }

    public function checkIn(Request $request, SlotService $slotService)
    {
        try {
            $this->validate($request, $this->rulesCheckInOut());
        }
        catch (ValidationException $e) {
            return response([
                'success' => false,
                'messages' => $e->errors()
            ]);
        }

        $idNo = $request->get('id_no');
        $classId = $request->get('class_id');
        $class = Classroom::find($classId);
        if(!$class) {
            return response([
                'success' => false,
                'message' => "data tidak ditemukan"
            ], 404);
        }
        $user = User::where('id_no', $idNo)->first();
        $message = null;
        switch ($user->role) {
            case Role::Teacher:
                $slot = Slot::where('seat', 'teacher')
                    ->where('class_id', $classId)->first();
                $slot->user_id = $user->id;
                $slot->save();
                break;
            case Role::Student:
                $slot = $slotService->getSlotByClassUser($classId, $user->id);

                if(!$slot)
                    $slot = $slotService->getSlotForStuden($classId);

                $message = "Hi {$user->name}, the class is fully seated";
                if($slot) {
                    $slot->user_id = $user->id;
                    $slot->save();
                    $message = "Hi {$user->name}, your seat  is {$slot->seat}";
                }
                break;
        }

        $class->load(['slots', 'slots.user']);
        $class->message = $message;

        return response(new ClassResource($class), 200);
    }

    public function checkOut(Request $request)
    {
        try {
            $this->validate($request, $this->rulesCheckInOut());
        }
        catch (ValidationException $e) {
            return response([
                'success' => false,
                'messages' => $e->errors()
            ]);
        }

        $idNo = $request->get('id_no');
        $classId = $request->get('class_id');

        $class = Classroom::find($classId);
        if(!$class) {
            return response([
                'success' => false,
                'message' => "data tidak ditemukan"
            ], 404);
        }

        $user = User::where('id_no', $idNo)->first();

        $message = null;
        switch ($user->role) {
            case Role::Teacher:
            case Role::Student:
                $slot = Slot::where('class_id', $classId)
                    ->where('user_id', $user->id)
                    ->first();
                if($slot) {
                    $slot->user_id = null;
                    $slot->save();
                }
                $message = "Hi {$user->name}, {$slot->seat} is now available for other students";
                break;
        }

        $class->load(['slots', 'slots.user']);
        $class->messages = $message;
        return response(new ClassResource($class), 200);
    }

    public function getClassList(){
        $class = Classroom::with('slots', 'slots.user')->get();

        return response(ClassResource::collection($class));
    }

    public function getClassById($id){
        $class = Classroom::with('slots', 'slots.user')->where('id', $id)->first();
        return response(new ClassResource($class));
    }
}
