import subprocess
import os


PROJECT_DIRECTORY = os.path.dirname(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
)
HOME_DIRECTORY = os.path.expanduser("~")


def run_dispatch(
    arguments: dict[str, bool | str], dispatch: dict[str, list], key: str
) -> None:
    if arguments[key]:
        [_run_simple_script(command) for command in dispatch[key]]


def _run_simple_script(command: list[str]) -> None:
    try:
        print(f"Running commands: {command}")
        proc = subprocess.Popen(
            command,
            stdout=subprocess.PIPE,
            text=True,
            bufsize=1,  # Enables line buffering
        )
        for line in proc.stdout:
            print(line.strip())
        proc.wait()

        print(f"\nCommand Finished!\nReturn code: {proc.returncode}\n\n")
    except subprocess.CalledProcessError as e:
        print(f"Command failed with return code {e.returncode}")
        print(f"Error output: {e.stderr}")
        raise Exception("Script execution failed!")
