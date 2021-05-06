#!/usr/bin/python3
import sys

def unique():
    data = set()
    for x in sys.stdin.readlines():
        if x not in data:
            print(x, end='')
            data.add(x)
        


def main():
    if len(sys.argv) == 1:
        # print all aliases
        print("alias unique='~/dotdotdot/system/functions.py unique';")
    elif sys.argv[1] == 'unique':
        unique()


if __name__ == "__main__":
    main()