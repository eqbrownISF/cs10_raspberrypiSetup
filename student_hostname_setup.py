import os

def sshHostname():
    print("\n -------------SSH RASPBERRY PI SETUP--------------")

    hostSuffix = input("Enter Raspberrypi Number: ")

    hostname = "raspberrypi-{}".format(hostSuffix)

    return hostname

def setup_sshTest(hostname):
    #Changes your ssh config to the given raspberry pi host name

    os.system("echo "" > ~/.ssh/config")
    sshString = "printf 'Host {}\n\tRemoteForward 52698 localhost:52698\n\tUser user' >> ~/.ssh/config".format(hostname)
    os.system(sshString)

    print("--Initialized your ssh config with the given Raspberry Pi number--")

def main():
    hostname = sshHostname()
    setup_sshTest(hostname)
main()