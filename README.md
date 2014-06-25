Mt. Everest from SRTM Data
==========================

Model of Mt. Everest generated from Shuttle Radar Topography Mission
(SRTM) 90m topographic data. This fulfills a promise (see
https://github.com/bld/Cho-Oyu-and-Ngozumpa-Glacier) to publish a
recipe for making your own topographic models from raw data.

The license is [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/).

Instructions
------------

I haven't printed this. You have been warned. The base of
"everest.stl" and "everest_reduced.stl" are a bit too tall, because
they are scaled from sea level. The model "everest_short.stl" was
manually shortened to use less material for printing.

These are the steps I took to generate a Mt. Everest model. The
principles should apply to other locations.

1. Download SRTM data from http://www.viewfinderpanoramas.org/dem3h.html

   Mt. Everest lies near the edge of longitude E086 and spans latitude
   N28. I downloaded both N27E086 and N28E086 to capture the entire
   area.

2. Convert SRTM HGT data to format usable by OpenSCAD's surface()
   function

   I used the Geospatial Data Abstraction Library (GDAL) command
   "gdal_translate" to convert the two SRTM HGT files to Arc/Info
   ASCII Grid (AAIGrid). The HGT files are 1201x1201 pixels. I
   extracted a 150x150 pixel square centered on Mt. Everest in two
   parts for each data file. One is a 150x100 section from N27E086.hgt
   starting from location (1050,0), the other is a 150x50 pixel block
   from N28E086.hgt from location (1050,1150). I found this by trial &
   error. Here are the commands from everest.sh: gdal_translate -of
   AAIGrid -srcwin 1050 0 150 100 N27E086.hgt N27E086.dat
   gdal_translate -of AAIGrid -srcwin 1050 1150 150 50 N28E086.hgt
   N28E086.dat Adding the "-outsize 50% 50%" option will reduce the
   data scale 50% for fewer polygons.

3. Join AAIGrid data into one file and comment out extraneous data

   I opened a new file "everest.dat" and inserted first N28E086.dat
   followed by N27E086.dat. I deleted the header information, so that
   only lines of height data (in meters) remain.

4. Render as a surface in OpenSCAD

   Use the "surface()" function with the file="everest.dat" option to
   render the file. I applied "mirror([0,1,0])" to flip the model,
   because surface() interprets x & y differently. Scale factors are
   very important. By default, surface() draws a box 1 unit wide for
   each pixel, with height from the numbers in the data file. This
   SRTM data is 90m per pixel, with vertical data in meters. See
   "everest.scad" for details.

5. Simplification 
   
   Topo models can still have an enormous number of polygons. I
   generated a simplified model using Meshlab: "Filters -> Remeshing,
   simplification, and reconstruction -> Quadric Edge Collapse
   Decimation." Applying 3 times reduced the size from 43707 vertices
   and 15 MB to 5465 vertices and 500 kB.
