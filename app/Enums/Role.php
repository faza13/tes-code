<?php

namespace App\Enums;

use BenSampo\Enum\Enum;

class Role extends Enum
{
    const Admin = 1;
    const Teacher = 2;
    const Student = 3;
}
