import argparse

import cv2


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-s", "--source", type=str, help="source path")
    return parser.parse_args()


def loop(source):
    while True:
        is_ok, frame = source.read()

        if not is_ok:
            print("End of stream...")
            break

        cv2.imshow("preview", frame)
        key = cv2.waitKey(1)
        if key == ord("q"):
            print("Exiting...")
            break


def main():
    args = parse_args()

    source_path = int(args.source) if args.source.isdigit() else args.source
    source = cv2.VideoCapture(source_path)

    try:
        loop(source)
    finally:
        cv2.destroyAllWindows()
        source.release()


if __name__ == "__main__":
    main()
