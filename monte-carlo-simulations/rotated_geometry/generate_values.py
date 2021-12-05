import math

SCANNER_ONE_Z = 277.4
SCANNER_TWO_Z = 461.8
START_ANGLE = 90
END_ANGLE = -94
f = open("transition_values.txt", 'w+')

for i in range(START_ANGLE, END_ANGLE-1, -1):
	s1_x_tran = round(SCANNER_ONE_Z * math.sin(math.radians(i)),5)
	s1_z_tran = round(SCANNER_ONE_Z * math.sin(math.radians(90-i)),5)
	
	s2_x_tran = round(SCANNER_TWO_Z * math.sin(math.radians(i)), 5)
	s2_z_tran = round(SCANNER_TWO_Z * math.sin(math.radians(90-i)), 5)
	
	f.write(str(i) + " " + str(s1_x_tran) + " " + str(s1_z_tran) + " " + str(s2_x_tran) + " " + str(s2_z_tran) + '\n')


f.close()
