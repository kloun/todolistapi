<?php

namespace App\Enums;

enum TaskStatus: string
{
    case TASK_NEW = "NEW";
    case TASK_PLANNING = "PLANNING";
    case TASK_IN_PROGRESS = "IN_PROGRESS";
    case TASK_DONE = 'DONE';
}
