from lib.parser import parse_flags, define_flags


def start_cli() -> None:
    parse_flags(define_flags())
