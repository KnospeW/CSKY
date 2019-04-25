fx = open("otherChroKmers_sorted.txt",'r')
fy = open("YChroKmers_distance_1_sorted.txt",'r')
fy_ori = open("YChroKmers_sorted.txt", 'r')
fw = open("onlyY_with_empty.txt", 'w')
x = fx.readline()
y = fy.readline()
y_data = fy_ori.readlines()

while True:
    if (x == '' or y == ''):
        break
    if x.strip("\n") == y.split()[0]:
        lineNum = int(y.split()[1]) - 1
        y_data[lineNum] = y_data[lineNum].replace(y_data[lineNum], '\n')
        x = fx.readline()
        y = fy.readline()
    elif x.strip("\n") < y.split()[0]:
        x = fx.readline()
    else:
        y = fy.readline()
fw.writelines(y_data)
