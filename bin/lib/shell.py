import subprocess
import os


def get_project_dir() -> str:
    return os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def run_simple_script(command: list[str]) -> subprocess.CompletedProcess:
    try:
        print(f"Running commands: {command}")
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        print(f"Result of command: {result.stdout}\nCode: {result.returncode}")
        return result
    except subprocess.CalledProcessError as e:
        print(f"Command failed with return code {e.returncode}")
        print(f"Error output: {e.stderr}")
        raise Exception("Script execution failed!")
