#!/usr/bin/python

import sys
import numpy as np

args = sys.argv[1:]

y = np.linspace(0,2*np.pi, 101 if len(args) == 0 else int(str(args[0])),endpoint=True)
x = np.sin(y)**2
x += 0.05
x = np.round(x,decimals=4)
y = np.round(y,decimals=4)
data = list(zip(list(x),list(y)))
results = '\n'.join([f'10*<{xi:.4f},{yi:.4f}>,' for xi,yi in data])[:-1]

settext = f'#declare Vase =\nsor{{ {len(data)},\n{results} }}'

with open("/Users/nilsseitz/Coding/Povray/computergraphik/src/rotationsvase.inc","w") as f:
    f.write(settext)


    
