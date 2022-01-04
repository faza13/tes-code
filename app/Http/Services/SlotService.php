<?php

namespace App\Http\Services;

use App\Models\Slot;

class SlotService
{
    public function getSlotByClassUser($classId, $userId)
    {
        return Slot::where('class_id', $classId)
            ->where('user_id', $userId)
            ->first();
    }

    public function getSlotForStuden($classId)
    {
        return Slot::where('seat', '<>','teacher')
            ->where('class_id', $classId)
            ->whereNull('user_id')
            ->orderBy('seat', 'asc')
            ->first();
    }
}
