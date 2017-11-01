import numpy as np

def mandel(a, max_iteration):
    b = a
    for x in range(max_iteration):
        if abs(a) > 2:
            return x
        a = a*a + b
    return max_iteration

def set(min_x,max_x,min_y,max_y,w,h,max):
    a = np.linspace(min_x, max_x, w)
    b = np.linspace(min_y, max_y, h)
    return (a,b,[mandel(complex(c, i),max) for c in a for i in b])
