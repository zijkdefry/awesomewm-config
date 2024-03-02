import sys, subprocess, json, time
from datetime import datetime

time_boot = time.time() - time.monotonic()
dunst_hist = json.loads(subprocess.run(['dunstctl', 'history'], capture_output=True).stdout)
notifications = dunst_hist['data'][0]

def dunst_ts_to_str_time(timestamp):
    return datetime.fromtimestamp(time_boot + timestamp / 1_000_000) \
        .strftime("%H:%M")

def nget(notif, key):
    return notif[key]['data']

def history():
    for i in reversed(range(len(notifications))):
        notif = notifications[i]
        appname = nget(notif, 'appname')
        summ = nget(notif, 'summary')
        timestamp = nget(notif, 'timestamp')

        notif_time = dunst_ts_to_str_time(timestamp)
        
        print(f'\x1B[1;38;5;156m[{notif_time}]\x1B[38;5;141m {appname}:\x1B[0m {summ}')

N = 3
if len(sys.argv) > 2:
    N = int(sys.argv[2])

def latest():
    for i in range(N):
        if i >= len(notifications):
            print(f'n{i}')
            continue
        
        notif = notifications[i]
        appname = nget(notif, 'appname')
        summ = nget(notif, 'summary')
        timestamp = nget(notif, 'timestamp')

        notif_time = dunst_ts_to_str_time(timestamp)

        print(f'y{i}#{notif_time}#{appname}#{summ}')
        

if len(sys.argv) > 1:
    match sys.argv[1]:
        case "history":
            history()
            input()
            sys.exit(0)
        case "latest":
            latest()
            sys.exit(0)
        case _:
            print("Unknown option")
            sys.exit(1)

print("No options provided")
sys.exit(1)
