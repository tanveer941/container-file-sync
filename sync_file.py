import subprocess

def sync_file():

    cmnd = r'rsync -rave "ssh -i sample_file_server.pem" -amuvWxq /source_folder' \
           r' admin@file_server.corp:/destination/output'
    execute_shell_command(command=cmnd)

def execute_shell_command(command):
    """This function runs the supplied command on the linux shell
    Args:
        param command: str - command to run on console
    :return: None
    """
    process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    process.wait()
    if process.returncode == 0:
        return True
    else:
        return False

if __name__ == '__main__':
    sync_file()