import subprocess
import os


def get_project_dir() -> str:
    return os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def run_simple_script(command: list[str]) -> None:
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
