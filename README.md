# TodoListAPI 

TodoListAPI is a task list backend API built with PHP and the Laravel framework.

# API Documentation
This API allows you to manage TODO tasks with titles, descriptions, and statuses.

Base URL Example: http://localhost:8000

## Endpoints

### 1. List All Tasks

Returns a list of all tasks.

URL: /tasks

Method: GET

Success Response (200 OK):

    {
        "data": [
            {
                "id": 1,
                "title": "Setup Laravel Herd",
                "description": "Install and configure the local environment.",
                "status": "DONE",
                "created_at": "2026-01-18 10:00:00",
                "updated_at": "2026-01-18 12:00:00"
            }
        ]
    }

#### 2. Create a Task

Creates a new task record.

URL: /tasks

Method: POST

Headers: Accept: application/json, Content-Type: application/json

Request Body rules:

| Field | Type | Required | Description |
| --- | --- | --- | --- | 
| title | string | Yes | Max 250 characters. Cannot be empty. |
| description | string  | No | Optional detailed text. |
| status | enum string | No | Options: NEW, PLANNING, IN_PROGRESS, DONE. ***Default: NEW***. |

Success Response (201 Created):

    {
        "data": {
            "id": 2,
            "title": "Complete Documentation",
            "description": "Write MD file for the API",
            "status": "NEW",
            "created_at": "2026-01-18 20:50:00",
            "updated_at": "2026-01-18 20:50:00"
        }
    }

### 3. Get Task by ID

Returns detailed information for a specific task by its ID.

URL: /tasks/{id}

Method: GET

Success Response example (200 OK):

    {
        "data": {
            "id": 2,
            "title": "Complete Documentation",
            "description": "Write MD file for the API",
            "status": "NEW",
            "created_at": "2026-01-18 20:50:00",
            "updated_at": "2026-01-18 20:50:00"
        }
    }


### 4. Update a Task

Updates an existing task. You can send only the fields you want to change (Partial Update).

URL: /tasks/{id}

Method: PUT (or PATCH)

Request Body: Same as Create Task (all fields optional). JSON body example:

    {
        "title": "Updated Title",
        "status": "IN_PROGRESS"
    }

Success Response (200 OK). Returns updated Task.

### 5. Delete a Task

Removes a task from the database.

URL: /tasks/{id}

Method: DELETE

Success Response (204 No Content)

Empty body

## Status Codes
* 200 OK - Request successful.
* 201 Created - Resource created successfully.
* 204 No Content - Resource deleted successfully.
* 404 Not Found - The task with the specified ID does not exist.
* 422 Unprocessable Entity - Validation failed (e.g., title is empty or too long).


