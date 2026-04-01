import subprocess
import os
from typing import List, Optional

# runs a single command; returns the ret code of the
# process if ret_output is False, otherwise returns
# the output of the process
def run_command(command_base: List[str],
                extra_args: List[str] = [],
                command_output_file: Optional[str] = None,
                ret_output: bool = False,
                print_output: bool = False):

    command = command_base + extra_args
    print("\t" + " ".join(command))
    p = subprocess.Popen(
        command,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        universal_newlines=False
    )

    output = "";
    if command_output_file != None:
        command_output_dir \
            = os.path.dirname(command_output_file)
        if not os.path.exists(command_output_dir):
            os.makedirs(command_output_dir)
        
        with open(command_output_file, "w") \
            as command_output_file:

            for raw in p.stdout:
                line = raw.decode("utf-8",
                                  errors="replace")
                line = line.rstrip()
                if ret_output:
                    output = output + line + "\n"
                if print_output:
                    print(line)
                command_output_file.write(line + "\n")
                command_output_file.flush()
    else:
        for raw in p.stdout:
            line = raw.decode("utf-8",
                              errors="replace")
            line = line.rstrip()
            if ret_output:
                output = output + line + "\n"
            if print_output:
                print(line)

    if not ret_output:
        returncode = p.wait()
        return str(returncode)
    else:
        return output