import paramiko, os


def runScript(file, client):
    # read the BASH script content from the file
    bash_script = open(file).read()

    bash_command = "yes | ./{}".format(bash_script)
    #print(bash_command)

    # execute the BASH script
    stdin, stdout, stderr = client.exec_command(bash_script)

    # read the standard output and print it
    print("--Standard Output")
    print(stdout.read().decode())

    # print errors if there are any

    err = stderr.read().decode()
    if err:
        print("--Errors--")
        print(err)

def runCommand(command, client):
# execute the BASH script
    stdin, stdout, stderr = client.exec_command(command)

    # read the standard output and print it
    print(stdout.read().decode())

    # print errors if there are any

    err = stderr.read().decode()
    if err:
        print("--READ OUT--")
        print(err)

def setup_sshTest(hostSuffix):
    #Changes your ssh config to the given raspberry pi host name

    os.system("echo "" > ~/.ssh/config")
    sshString = "printf 'Host {}\n\tRemoteForward 52698 localhost:52698\n\tUser user' >> ~/.ssh/config".format(hostSuffix)
    os.system(sshString)

    print("--Initialized your ssh config to test ssh with the given raspberry pi--")


def wgetFiles(scriptList,client):
    #Downloads setup scripts from github to rapsberry pi

    
    for script in scriptList:
        wget_command = "wget https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/{}".format(script)
        
        runCommand(wget_command,client)
        scriptInit_command = "sudo chmod +x {}".format(script)
        runCommand(scriptInit_command, client)
    
def wgetFile(file,client):
    wget_command = "wget https://raw.githubusercontent.com/the-isf-academy/cs10_raspberrypiSetup/master/{}".format(file)
        
    runCommand(wget_command,client)
    scriptInit_command = "sudo chmod +x {}".format(file)
    runCommand(scriptInit_command, client)

def sshHostname():
    print("\n -------------HOSTNAME INIT--------------")
    print("1. Raspberrypi-X")
    print("2. IP address\n")

    option = input("Enter option: ")

    if int(option) == 1:
        hostSuffix = input("Enter Hostname Suffix: ")
        hostname = "raspberrypi-{}".format(hostSuffix)

    elif int(option) == 2:
        hostname = input("Enter IP address: ")

    return hostname
        


def main():
    #raspberry pi admin init 
    username = "pi"
    password = "cs10_2020_teacher"
    hostname = sshHostname()
    print(hostname)

    #Set up ssh config for ssh testing
    setup_sshTest(hostname)

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        client.connect(hostname=hostname, username=username, password=password)
    except:
        print("[!] Cannot connect to the SSH Server")
        exit()

    #set up variable init 
    scriptList = ["setup1.sh","setup2a.sh","setup2b.sh","setup3.sh","removeFiles.sh"]
    runFile_command = "yes | ./{}"

    while True:
        print("\n -------------SET UP--------------")
        print("1. Setup 1: Updating Raspberrypi, pip, rmate")
        print("2. Setup 2: Python3.8")
        print("3. Setup 3: Mesh Network")
        print("4. Download Setup files")
        print("//Press any other key to exit//\n")

        option = input("Enter option: ")
        print('\n')

    
    

        if int(option) == 1:
            runFile_command_1 = runFile_command.format(scriptList[0])
            runCommand(runFile_command_1,client)

        elif int(option) == 2:
            while True:
                print("\n -------------PYTHON3.8 SET UP--------------")
                print("1. Download Python3.8 Files")
                print("2. Install Python3.8 Files")
                print("3. Go back to previous menu\n")

                option = input("Enter option: ")
                print('\n')

            
                if int(option) == 1:
                    runFile_command_2a = runFile_command.format(scriptList[1])
                    runCommand(runFile_command_2a,client)
                elif int(option) == 2:
                    runFile_command_2b = runFile_command.format(scriptList[2])
                    runCommand(runFile_command_2b,client)
                elif int(option) ==3:
                    break
                
        elif int(option) == 3:
            runFile_command_3 = runFile_command.format(scriptList[3])
            runCommand(runFile_command_3,client)
        elif int(option) == 4:
            #removes files 
            wgetFile(scriptList[4],client)
            runFile_command_4 = runFile_command.format(scriptList[4])
            runCommand(runFile_command_4,client)

            wgetFiles(scriptList[0:4],client)

        else:
            break
    
    client.close()


main()
