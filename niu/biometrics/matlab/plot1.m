axis([0  800 -800  0])

load pixel.dat

ax = pixel(:,1)
ay = pixel(:,2)

plot(ax, ay, 'r+');