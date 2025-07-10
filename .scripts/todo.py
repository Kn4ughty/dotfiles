#!/bin/env python3
"""
# Arguments
add - "Add task from stdin json"
delete - delete task with uuid from stdin


# Example ouput for ./todo get
{
    [
        {
            "text": "im a todo",
            "checked": "false",
            "due": "31/04/2025",
            "uuid": "198273ujlkn12367y1n2kj3789"
        }
        ... and so on
    ]
}
"""

import sqlite3
import json
import uuid
