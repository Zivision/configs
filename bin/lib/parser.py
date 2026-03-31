import argparse
from lib.shell import run_dispatch, PROJECT_DIRECTORY, HOME_DIRECTORY

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
        help="Run 'rebuild' steps",
    )
    parser.add_argument(
        "-u",
        "--update",
        action="store_true",
        help="Run 'update-system' script",
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
        help="Run 'install' instructions",
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
            [PROJECT_DIRECTORY + "/bin/lib/elisp/main.el"],
            [PROJECT_DIRECTORY + "/bin/configure-system"],
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
                (PROJECT_DIRECTORY + "/nixos#" + str(args["rebuild"])),
                "--impure",
            ]
        ],
        "install": [
            [
                "sudo",
                "nixos-rebuild",
                "switch",
                "--flake",
                (PROJECT_DIRECTORY + "/nixos#" + str(args["install"])),
                "--impure",
            ],
            # Clone DOOM Emacs repo and install it
            [
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/doomemacs/doomemacs",
                (HOME_DIRECTORY + "/.config/emacs"),
            ],
            [(HOME_DIRECTORY + "/.config/emacs/bin/doom"), "install"],
        ],
    }

    # This checks for commands in order.
    # Currently it is:
    # 1. Configure
    # 2. Install
    # 3. Updates
    # 4. Rebuild

    run_dispatch(args, dispatch, "configure")
    run_dispatch(args, dispatch, "install")

    for key in ["update", "update_flatpak", "update_all"]:
        run_dispatch(args, dispatch, key)

    run_dispatch(args, dispatch, "rebuild")
