import subprocess


def run_simple_script(command: list[str]) -> subprocess.CompletedProcess:
    try:
        print(f"Running commands: {command}")
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        return result
    except subprocess.CalledProcessError as e:
        print(f"Command failed with return code {e.returncode}")
        print(f"Error output: {e.stderr}")
        raise Exception("Script execution failed!")
