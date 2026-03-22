import argparse
from lib.shell import run_dispatch, run_dispatch_install, get_project_dir

import sys


def define_flags() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="CLI Wrapper for common nixos system processes"
    )

    parser.add_argument(
        "-c",
        "--configure",
        action="store_true",
        help="Run 'configure-system' script",
    )
    parser.add_argument(
        "-r",
        "--rebuild",
        help="Run 'rebuild-system' script",
    )
    parser.add_argument(
        "-u",
        "--update",
        action="store_true",
        help="Run 'rebuild-system' script",
    )
    parser.add_argument(
        "-uf",
        "--update-flatpak",
        action="store_true",
        help="Run 'flatpak update'",
    )
    parser.add_argument(
        "-U",
        "--update-all",
        action="store_true",
        help="Run full system update",
    )
    parser.add_argument(
        "-i",
        "--install",
        help="Run 'install-system' script",
    )

    return parser


def show_help_menu(
    parser: argparse.ArgumentParser,
    arguments: dict[str, bool | str | None],
    target_type: type,
) -> None:
    # Checks for TARGET_TYPE in arguments
    checked_type: bool = any(
        isinstance(value, target_type) for value in arguments.values()
    )

    if not checked_type and True not in arguments.values():
        parser.print_help()
        sys.exit(0)


def parse_flags(parser: argparse.ArgumentParser) -> None:
    args = vars(parser.parse_args())
    # If none of the configuration flags are true
    # And there is no string
    # Print help menu and exit program
    show_help_menu(parser, args, str)

    # Commands to dispatch
    dispatch = {
        "configure": [
            [get_project_dir() + "/bin/lib/elisp/main.el"],
            ["configure-system"],
        ],
        "update": [["update-system"]],
        "update_flatpak": [["flatpak", "update"]],
        "update_all": [
            ["update-system"],
            ["flatpak", "update"],
        ],
        "rebuild": [
            [
                "sudo",
                "nixos-rebuild",
                "switch",
                "--flake",
                (get_project_dir() + "/nixos#" + str(args["rebuild"])),
                "--impure",
            ]
        ],
        "install": [
            [get_project_dir() + "/bin/lib/elisp/main.el"],
            ["configure-system"],
        ],
    }

    # This checks for commands in order.
    # Currently it is:
    # 1. Install (it runs everything in order within it's bash script)
    # 2. Configure
    # 3. Updates
    # 4. Rebuild

    # run_dispatch(args, dispatch, "install")
    run_dispatch(args, dispatch, "install")
    run_dispatch(args, dispatch, "configure")

    for key in ["update", "update_flatpak", "update_all"]:
        run_dispatch(args, dispatch, key)

    run_dispatch(args, dispatch, "rebuild")
