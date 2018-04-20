from urllib.request import urlopen

def calcTime():
    """
    Grab time from website and get the hour and min (uncalculated)
    :return: list of hour and min
    """
    timeLst = list()
    res = urlopen('https://just-the-time.appspot.com/')
    time_str = res.read().strip()
    updated_time_str = time_str.decode('utf-8')
    time = updated_time_str.split(" ")
    del time[0] #deletes seconds (unused)
    hourmin = time[0].split(":")  # hour/min/sec
    hour = (int(hourmin[0]) - 4)
    timeLst.append(hour)
    mintim = int(hourmin[1])
    timeLst.append(mintim)
    return timeLst

def minCalc(min):
    """
    Recursively round down to the nearest
    :param min: number to round down to near whole fifth number
    :return: final calculated result after recursion
    """
    if min % 5 != 0:
        return minCalc(min-1)
    else:
        return min

def main():
    time_lst = calcTime() #first index is hour and second is the min
    print(str(time_lst[0]) + str(minCalc(time_lst[1])))

main()
