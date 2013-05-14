function writepgm(image,filename)
%WRITEPGM Write a matrix as a raw pgm file
%         WRITEPGM(IMAGE,FILENAME) writes the array image as a raw PGM
%         file to FILENAME.
%
% Matthew Dailey 1999
[m,n] = size(image);
% if ~((image <= 255) && (image >= 0))
% error('Image pixels out of range.');
% end;
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
