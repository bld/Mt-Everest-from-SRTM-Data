// Model of Mt. Everest
// 90m SRTM data
// 150x150 pixels -> 13,500m x 13,500m
// 1/135 scale -> makes for 10cm print

datascale=1; // Data scaled by 50%
pixelsize=90/datascale; // Pixel size nominally 90m, divide by scale
datax=75; // Number of data columns
datay=75; // Number of data rows
scale=1/135; // Scale
// Mirror because OpenSCAD's surface() interprets data differently
mirror([0,1,0])
	scale([scale*pixelsize,scale*pixelsize,scale])
		surface(file="everest.dat",center=true);
