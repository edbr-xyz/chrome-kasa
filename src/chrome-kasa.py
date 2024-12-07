import time
import subprocess
import sys
def main():
    chromecast = sys.argv[1].replace('###space###', ' ')
    kasaPlug = sys.argv[2]
    sleepTime = idle = int(sys.argv[3])
    print('Controlling Kasa plug at', kasaPlug, 'based on the status of', chromecast)
    ampStatus = "unknown"
    while True:
        if str.encode('"appType\\":\\"WEB\\"') in subprocess.Popen(['go-chromecast','status', '-n', chromecast, '-v'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0]:
            idle = 0
            if ampStatus != "on":
                subprocess.run(["kasa", "--type", "plug", "--host", kasaPlug, "on"])
                ampStatus = "on"
        elif sleepTime > idle:
            idle += 1
        elif ampStatus != "off":
            subprocess.run(["kasa", "--type", "plug", "--host", kasaPlug, "off"])
            ampStatus = "off"

        time.sleep(1)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass