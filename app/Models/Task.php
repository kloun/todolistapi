<?php

namespace App\Models;

use App\Enums\TaskStatus;
use Illuminate\Database\Eloquent\Model;

class Task extends Model
{
    protected function casts():array
    {
        return [
            'status' => TaskStatus::class
        ];
    }
    protected $guarded = [];
    
}
