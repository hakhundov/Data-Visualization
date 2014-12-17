of = open("HM.csv", "r")
nf = open("HM2.csv", "w")

nf.write("x,y,v\n")

for line in of:
	nf.write(line)

of.close()
nf.close()