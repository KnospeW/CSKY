import glob
import csv
import os

count = 0
path = "./sorted*.txt"
countlist = []
for filename in glob.glob(path):
    count = 0
    with open("./../humanGeno/onlyY.txt", 'r') as fy:
        with open(filename, 'r') as fx:
            x = fx.readline()
            y = fy.readline()
            while True:
                if (x == '' or y == ''):
                    break
                if x.strip("\n") == y.strip("\n"):
                    count += 1
                    x = fx.readline()
                    y = fy.readline()
                elif x.strip("\n") < y.strip("\n"):
                    x = fx.readline()
                else:
                    y = fy.readline()
    fx.close()
    fy.close()
    countlist.append(count)
    countlist.sort(reverse=True)

path1 = "./*coverage.txt"
file, extension = os.path.splitext(os.path.basename(glob.glob(path1)[0]))
countlist.append(file.split('_')[1])

with open("result_1.0coverage_excepted.csv", "a+") as f:
    writer = csv.writer(f, delimiter=",")
    writer.writerow(countlist)
    f.close()
