input = open("YChroKmers_sorted.txt",'r')
y_marked = open("YChroKmers_marked.txt",'w')
n = 0
data = input.readlines()
for line in data:
    n += 1
    y_marked.write(line.strip().split('\n')[0] + ' ' + str(n) + '\n')
input.close()
y_marked.close()

y_marked = open("YChroKmers_marked.txt",'r')
y_distance_1 = open("YChroKmers_distance_1.txt",'w')
n = 0
data = y_marked.readlines()
length = len(data)
for line in data:
    y_distance_1.write(line)
    for i in range(0, 25):
        if (line[i] == 'A'):
            y_distance_1.write(line[:i] + "T" + line[(i + 1):])
            y_distance_1.write(line[:i] + "C" + line[(i + 1):])
            y_distance_1.write(line[:i] + "G" + line[(i + 1):])
        elif (line[i] == 'T'):
            y_distance_1.write(line[:i] + "A" + line[(i + 1):])
            y_distance_1.write(line[:i] + "C" + line[(i + 1):])
            y_distance_1.write(line[:i] + "G" + line[(i + 1):])
        elif (line[i] == 'C'):
            y_distance_1.write(line[:i] + "A" + line[(i + 1):])
            y_distance_1.write(line[:i] + "T" + line[(i + 1):])
            y_distance_1.write(line[:i] + "G" + line[(i + 1):])
        elif (line[i] == 'G'):
            y_distance_1.write(line[:i] + "A" + line[(i + 1):])
            y_distance_1.write(line[:i] + "T" + line[(i + 1):])
            y_distance_1.write(line[:i] + "C" + line[(i + 1):])

y_marked.close()
y_distance_1.close()
