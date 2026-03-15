import subprocess
from pathlib import Path

xenv = __xonsh__.env

path_directories = []

for d in path_directories:
    xenv["PATH"].append(Path(d).expanduser())


#$PROMPT = '[{localtime}] {YELLOW}{env_name} {BOLD_BLUE}{user}@{hostname} {BOLD_GREEN}{cwd} {gitstatus}{RESET}\n@ '
#$XONSH_COLOR_STYLE = 'monokai'

xenv["XONSH_COLOR_STYLE"] = "monokai"
