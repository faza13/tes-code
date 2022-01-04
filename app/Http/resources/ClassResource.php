<?php

namespace App\Http\resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ClassResource extends JsonResource
{
    public function toArray($request)
    {
        $availableSeats = $this->slots->filter(function($v){
            return $v->user_id == null && $v->seat != 'teacher';
        })->pluck('seat');

        $teacher = $this->slots->filter(function($v){
            return $v->seat == 'teacher';
        })->first();

        $occupiedSeat = $this->slots->filter(function($v){
            return $v->user_id != null && $v->seat != 'teacher';
        })->map(function($v) {
            return [
                'seat' => $v->seat,
                'student_name' => $v->user->name ?? 'name'
            ];
        });

        $result = [
            "class_id" => $this->id,
            "rows" => $this->rows,
            "columns" => $this->columns,
	        "teacher" => $teacher->user_id ? "in" : "out", // ["in", "out"]
	        "available_seats" => $availableSeats,
            "occupied_seats" => $occupiedSeat,
            "message" => $this->message ?? '' // ["Hi <student_name>, your seat  is <seat>", "Hi <student_name>, the class is fully seated", "Hi <student_name>, <seat> is now available for other students"]
        ];

        return $result;
    }
}
