import argparse
from lib.shell import run_simple_script, get_project_dir


def define_flags() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="CLI Wrapper for common nixos system processes"
    )

    parser.add_argument(
        "-c", "--configure", action="store_true", help="Run 'configure-system' script"
    )
    parser.add_argument(
        "-r", "--rebuild", action="store_true", help="Run 'rebuild-system' script"
    )
    parser.add_argument(
        "-u", "--update", action="store_true", help="Run 'rebuild-system' script"
    )
    parser.add_argument(
        "-uf",
        "--update-flatpak",
        action="store_true",
        help="Run 'flatpak update'",
    )
    parser.add_argument(
        "-ua", "--update-all", action="store_true", help="Run full system update"
    )
    parser.add_argument(
        "-i", "--install", action="store_true", help="Run 'install-system' script"
    )

    return parser


def parse_flags(parser: argparse.ArgumentParser) -> None:

    # Commands to dispatch
    dispatch = {
        "configure": [
            [get_project_dir() + "/lib/tangle-config.el"],
            ["configure-system"],
        ],
        "update": [["update-system"]],
        "update_flatpak": [["flatpak", "update"]],
        "update_all": [
            ["update-system"],
            ["flatpak", "update"],
        ],
        "rebuild": [["rebuild-system"]],
        "install": [["install-system"]],
    }

    args = vars(parser.parse_args())

    for key in dispatch:
        if args[key]:
            [run_simple_script(command) for command in dispatch[key]]

    if True not in args.values():
        parser.print_help()
