#!/usr/bin/env python3

import subprocess
import re


class KernelInfo:
    def __init__(self, name, version):
        self.name = name
        self.version = version

    @classmethod
    def from_package_string(cls, package_string):
        package_name = package_string.split("/")[0]
        version = re.sub(r"linux-image-(unsigned-)?", "", package_name)
        return cls(package_name, version)

    def __repr__(self) -> str:
        return f"Kernel: {self.name}"


def get_all_installed_packages():
    return subprocess.check_output(
        "apt list --installed", stderr=subprocess.STDOUT, shell=True, encoding="utf-8"
    ).splitlines()


def get_all_installed_kernels(packages_list):

    return [
        KernelInfo.from_package_string(p)
        for p in packages_list
        if p.startswith("linux-image-")
    ]


def get_all_modules_for_kernel(packages_list, kernel):
    return [p.split("/")[0] for p in packages_list if kernel.version in p]


def check_if_module_is_in_modules_list(module, modeules_list):
    return any(module in m for m in modeules_list)


def find_missing_modules(modeules_list):
    MODULES_TO_CHECK = [
        "linux-headers",
        "linux-image",
        "linux-modules",
        "linux-modules-extra",
    ]

    missing_modules = []

    for module in MODULES_TO_CHECK:
        if not check_if_module_is_in_modules_list(module, modeules_list):
            missing_modules.append(module)

    return missing_modules


def main():
    packages_list = get_all_installed_packages()
    kernels = get_all_installed_kernels(packages_list)

    for kernel in kernels:
        modules = get_all_modules_for_kernel(packages_list, kernel)
        missing_modules = find_missing_modules(modules)

        if missing_modules:
            print(f"Found missing modules for {kernel}")
            print("To install run:")
            print(
                f"\tsudo apt install {' '.join(f'{m}-{kernel.version}' for m in missing_modules)}"
            )
            print()
        else:
            print(f"{kernel} is ok.")


if __name__ == "__main__":
    main()
