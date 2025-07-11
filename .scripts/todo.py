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
            "due": 1752205583,
            "uuid": 166881016882768106246742576731943137064
        }
        ... and so on
    ]
}
"""

import sqlite3
from dataclasses import dataclass, asdict
import json
import argparse
from pathlib import Path
import os
from watchdog.events import FileSystemEvent, FileSystemEventHandler
from watchdog.observers import Observer
import time

DATABASE_PATH=Path("~/.local/share/todo.sqlite3").expanduser()

global con
global cur
con = sqlite3.connect(DATABASE_PATH)
cur = con.cursor()

@dataclass
class Task():
    id: int
    text: str
    checked: bool = False
    due: int = 0


class ChangeHandler(FileSystemEventHandler):
    def __init__(self, path):
        self.path = os.path.abspath(path)

    def on_modified(self, event):
        if os.path.abspath(event.src_path) == self.path:
            self.con = sqlite3.connect(DATABASE_PATH)
            self.cur = self.con.cursor()
            get_tasks(self.cur)


def watch_file(path):
    handler = ChangeHandler(path)
    observer = Observer()
    observer.schedule(handler, path=os.path.dirname(path), recursive=False)
    observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()


def add_task(text):
    cur.execute("""
        INSERT INTO tasks (text)
        VALUES (?)""", 
                (text,)) # trailing comma to create single element tuple
    con.commit()
    return 0


def delete_task(id):
    cur.execute("""
        DELETE FROM tasks WHERE id=(?)
    """, (id,))
    con.commit()
    return 0

def get_tasks(cur):
    res = cur.execute("SELECT * FROM tasks")
    tasks = res.fetchall()

    task_list = []
    for task in tasks:
        # hope the scheme never changes!
        task_list.append(Task(task[0], task[1], bool(task[2]), task[3]))

    d = [asdict(task) for task in task_list]
    for task in d:
        task["selected"] = False

    s = json.dumps(d)
    print(s, flush=True)
    return 0

def update_task(id, text, checked, due):
    print(id, text, checked, due)

    cur.execute("""UPDATE tasks 
        SET
            text = CASE WHEN ? IS NOT NULL THEN ? ELSE text END,
            checked = CASE WHEN ? IS NOT NULL THEN ? ELSE checked END,
            due = CASE WHEN ? IS NOT NULL THEN ? ELSE due END
        WHERE id = ?
        """, (text, text, checked, checked, due, due, id))

    con.commit()
    return 0


if __name__ == "__main__":
    try:
        cur.execute("""CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text TEXT NOT NULL,
            checked bool DEFAULT False,
            due INTEGER DEFAULT 0
        )""")
    except sqlite3.OperationalError:
        # Table must already exist
        pass
    
    parser = argparse.ArgumentParser(
        prog="./todo.py",
        description="description"
    )
    parser.add_argument("action",
                        choices=['add', 'delete', 'get', 'update', 'watch'],
                        help="What to do")
    parser.add_argument("-i", "--id")
    parser.add_argument("-t", "--text")
    parser.add_argument("-c", "--checked")
    parser.add_argument("-d", "--due")

    args = parser.parse_args()

    match args.action:
        case "add":
            code = add_task(args.text)
        case "get":
            code = get_tasks(cur)
        case "delete":
            code = delete_task(args.id)
        case "update":
            code = update_task(args.id, args.text, args.checked, args.due)
        case "watch":
            get_tasks(cur)
            con.close()
            watch_file(DATABASE_PATH)
            code = 0
        case _:
            # how did i get here. Should be impossible
            code = 1

    con.close()
    exit(code)
