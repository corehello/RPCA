function image = readpgm(filename)
%READPGM Read a raw pgm file as a matrix
%
%        IMAGE = READPGM(FILENAME) reads the binary PGM image data from
%        the file named FILENAME and returns the image as a 2-dimensional
%        array of integers IMAGE. Assumes the file is a raw PGM file
%        containing 8-bit unsigned character data to represent pixel values.
%
% Matthew Dailey, 1997
% Open the file
fid = fopen(filename,'r');
% Parse and check the header information. No # comments allowed.
A = fgets(fid);
if strcmp(A(1:2),'P5') ~= 1
	error('File is not a raw PGM');
end;
A = fgets(fid);
sizes = sscanf(A,'%d');
w = sizes(1);
h = sizes(2);
A = fgets(fid);
max = sscanf(A,'%d');
tlength = w*h;
if max ~= 255
error('Cannot handle anything but 8-bit graymaps');
end;
% Read the raw data
[v,count] = fread(fid,inf,'uchar');
if count ~= tlength
error('File size does not agree with specified dimensions.');
end;
% Pack the column vector v into the image matrix
image = reshape(v,w,h)';
fclose(fid);

function writepgm(image,filename)
%WRITEPGM Write a matrix as a raw pgm file
%         WRITEPGM(IMAGE,FILENAME) writes the array image as a raw PGM
%         file to FILENAME.
%
% Matthew Dailey 1999
if ~(image <= 255 & image >= 0)
error('Image pixels out of range.');
end;
% Open the file
%fprintf(1,'Opening %s...\n',filename);
fid = fopen(filename,'w');
if fid <= 0
error(sprintf('Could not open %s for writing.',filename));
end;
width = size(image,2);
height = size(image,1);
% Write header information
fprintf(fid,'P5\n');
fprintf(fid,'%d %d\n',width,height);
fprintf(fid,'255\n');
% Write the raw data -- transpose first though
count = fwrite(fid,image','uchar');
if count ~= width*height
error(sprintf('Could not write all data to %s', outfile));
end;
fclose(fid);
