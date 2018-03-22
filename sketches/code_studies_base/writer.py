"""
author: austin ce
"""
import sys
from io import StringIO
import contextlib
import sh
import os
from random import random

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

INSTRUCTIONS_FILEPATH = os.path.join(DIR_PATH, "instructions.py")
OUTPUT_FILEPATH = os.path.join(DIR_PATH, "output.txt")

START = "------start-----"
END = "------end-----"


@contextlib.contextmanager
def stdoutIO(stdout=None):
    """
    Replaces stdout
    https://stackoverflow.com/questions/3906232/python-get-the-print-output-in-an-exec-statement
    """
    old = sys.stdout
    if stdout is None:
        stdout = StringIO()
    sys.stdout = stdout
    try:
        yield stdout
    except Exception:
        print("HWIOJDS")
    finally:
        sys.stdout = old


def reset_file(filename: str):
    with open(filename, 'w') as f:
        f.truncate()


def exec_instructions():
    """
    Runs the instructions in the instructions file and saves them to the output file
    """
    # Take all instructions in instructions.py and send the output to the output file
    to_exec = ""
    for line_num, line in enumerate(sh.tail("-f", INSTRUCTIONS_FILEPATH, _iter=True)):
        if line_num % (int(random() * 5000) + 1) == 0:
            print("Ugh.")

        if START in line:
            to_exec = ""
        elif END in line:
            print("Doing #" + str(line_num) + ".")
            with open(OUTPUT_FILEPATH, 'a+') as output_file, stdoutIO(output_file):
                print(START)
                exec(to_exec)

                if line_num % (int(random() * 5000) + 1) == 0:
                    print("H\nE\nL\nP")

                print(END)
        else:
            to_exec += line


if __name__ == "__main__":
    print("Resetting files, Processing master.")
    reset_file(INSTRUCTIONS_FILEPATH)
    reset_file(OUTPUT_FILEPATH)
    print("Listening for instructions, your highness.")
    exec_instructions()
