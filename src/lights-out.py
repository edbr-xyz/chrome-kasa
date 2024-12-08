import sys
import time
import subprocess
def main():
        chromecast = sys.argv[1].replace('###space###', ' ')
        kasaPlug = sys.argv[2]
        sleepTime = tvIdle = int(sys.argv[3])
        minLength = sleepTime * 2
        plugStatus = "unknown"
        while True:
            goStatus = str(subprocess.Popen(['go-chromecast','status', '-n', chromecast, '-v'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT).communicate()[0])
            if '(PLAYING)' in goStatus or '(BUFFERING)' in goStatus:
                if 'mediaCategory\\":\\"AUDIO' not in goStatus and int(''.join(filter(str.isdigit, goStatus.split('/')[-1].split('s')[0]))) > minLength:
                     tvIdle = 0
                     if plugStatus != 'off':
                        subprocess.run(["kasa", "--type", "plug", "--host", kasaPlug, "off"])
                        plugStatus = "off"
            elif sleepTime > tvIdle:
                    tvIdle += 1
            elif plugStatus != "on":
                subprocess.run(["kasa", "--type", "plug", "--host", kasaPlug, "on"])
                plugStatus = "on"
        
            time.sleep(1)

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
