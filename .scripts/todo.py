#!/bin/env python3
"""
# Arguments
add text='im a todo' etc... - add task from arguments
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
from dataclasses import dataclass
import json
import argparse
import uuid
from pathlib import Path
import sys
from typing import Optional

DATABASE_PATH=Path("~/.local/share/todo.sqlite3").expanduser()

global con
global cur
con = sqlite3.connect(DATABASE_PATH)
cur = con.cursor()

@dataclass
class Task():
    id: bytes
    text: str
    checked: bool
    due: Optional[str]


def add_task():
    # Convert stdin str to json
    a = json.load(sys.stdin)
    print(a)


    # cur.execute()
    pass

def delete_task():
    pass

def get_tasks():
    res = cur.execute("SELECT * FROM tasks")
    print(res.fetchall())
    pass

if __name__ == "__main__":
    try:
        cur.execute("""CREATE TABLE tasks (
            id str PRIMARY KEY,
            text str NOT NULL,
            checked bool DEFAULT False,
            due str
        )""")
    except sqlite3.OperationalError:
        # Table must already exist
        pass
    
    parser = argparse.ArgumentParser(
        prog="./todo.py",
        description="description"
    )
    parser.add_argument("action",
                        choices=['add', 'delete', 'get'],
                        help="What to do")
    parser.add_argument("-i", "--id")
    parser.add_argument("-t", "--text")
    parser.add_argument("-c", "--checked")


    parser.parse_args()

    # args = sys.argv
    # if len(sys.argv) != 2:
    #     print("invalid number of arguments", file=sys.stderr)
    #     exit(1)
    #
    # match args[1]:
    #     case "add":
    #         add_task()
    #     case "delete":
    #         delete_task()
    #     case "get":
    #         get_tasks()
    #     case _:
    #         get_tasks()

    exit(0)
