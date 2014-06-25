#!/bin/sh
gdal_translate -of AAIGrid -srcwin 1050 0 150 100 N27E086.hgt N27E086.dat
gdal_translate -of AAIGrid -srcwin 1050 1150 150 50 N28E086.hgt N28E086.dat
