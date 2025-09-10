#!/usr/bin/env python3

import subprocess
import json


def sway_get_workspaces():
    output = subprocess.check_output(["swaymsg", "-t", "get_workspaces"])
    return json.loads(output.decode("utf-8"))


class TreeNode:
    def __init__(self, ori: str, children=None, name=None):
        self.ori = ori
        self.children = children
        self.name = name

    def __str__(self):
        s = ""
        s += 'ori ' + self.ori + '\n'

        if self.children is not None:
            s += "("
            for child in self.children:
                s += child.__str__()
            s += ")"
        return s

    def to_yuck(self, indent=0):
        # TODO. Remove unrequired whitespace
        sp = "  " * indent
        if self.children:
            orient = self.ori.lower()
            s = f'{sp}(box :orientation "{
                orient}" :hexpand true :vexpand true :class "container" \n'
            for child in self.children:
                s += child.to_yuck(indent + 1) + "\n"
            s += f"{sp})"
            return s
        # We must be a leaf node

        return f'{sp}(box :class "workspace_window" "{self.name}")'


def parse_layout(s: str):
    """ in a form like this:
    layout = V[H[vesktop] H[steam]]

    output = '(box :orientation "v"
        (box :orientation "h")
        (box :orientation "h")
        )'

    """

    if s is None or len(s) == 0:
        return TreeNode("h", name="Empty")

    s = s.strip()

    idx = 0

    def parse() -> TreeNode:
        nonlocal idx

        if idx >= len(s):
            raise ValueError("unexpected end of string")

        ori = s[idx]
        idx += 1

        if idx < len(s) and s[idx] == "[":
            idx += 1
            children = []

            while idx < len(s) and s[idx] != "]":
                if s[idx].isspace():
                    idx += 1
                    continue
                children.append(parse())

            if idx >= len(s) or s[idx] != "]":
                raise ValueError("AAA MISSING CLOSING BRACKET")

            idx += 1
            return TreeNode(ori, children)

        # We must be at a leaf node
        idx -= 1  # correct for pre indexing
        name = ""
        while idx < len(s) and s[idx] not in " []":
            name += s[idx]
            idx += 1
        return TreeNode(ori, name=name)

    root = parse()

    if idx != len(s):
        raise ValueError("theres been a problem")

    return root


def sway_generate_workspace_data() -> dict:
    data = {}
    for wsp in sway_get_workspaces():

        if wsp["output"] not in data:
            data[wsp["output"]] = []

        i = {"name": wsp["name"],
             "monitor": wsp["output"],
             "focused": wsp["focused"],
             "visible": wsp["visible"],
             "rep": parse_layout(wsp["representation"]).to_yuck()
             }

        if wsp["focused"]:
            i["class"] = "focused"
            i["icon"] = ""
        elif wsp["visible"]:
            i["class"] = "visible"
            i["icon"] = ""
        else:
            i["class"] = "hidden"
            i["icon"] = ""

        # print("Layout!")
        # print(parse_layout(wsp["representation"]).to_yuck())
        # print("_________")

        # i["rep"] = gen_yuck_rep(wsp["representation"])

        data[wsp["output"]].append(i)

    return data


if __name__ == "__main__":
    process = subprocess.Popen(
        ["swaymsg", "-t", "subscribe", "-m", '["workspace"]', "--raw"],
        stdout=subprocess.PIPE,
    )
    if process.stdout is None:
        print("Error: could not subscribe to sway events")
        exit(1)

    while True:
        print(json.dumps(sway_generate_workspace_data()), flush=True)
        # This just maakes it wait until something changes before getting the data again
        line = process.stdout.readline().decode("utf-8")
        if line == "":
            break
