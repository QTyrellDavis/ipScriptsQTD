%2/4/2013 Q. Tyrell Davis
%This is a script for demosaicing Bayer filter array from a camera sensor (raw date
%it assigns an average of nearest neighber values for each color channel.
%The usage is demoseNN(img) where img is an mXn matrix representing raw camera data. The filters on the pixel must be in the following arrangement:
%
%  R G R G R G R G
%  G B G B G B G B
%  R G R G R G R G
%  G B G B G B G B ......
%
%if (odd,odd) then pixel is on a diagonal and is a R pixel
% if (even, even) then pixel is on diagonal, but is a B pixel
%if (even, odd) or (odd, even) then the pixel must be a green filtered pixel

function [colourImg] = demoseyNN(img)

%generate a mXnX3 matrix representing the colour version of the image. 
colourImg = zeros(size(img,1),size(img,2),3);

%if (odd,odd) then pixel is on a diagonal and is a R pixel
% if (even, even) then pixel is on diagonal, but is a B pixel
%if (even, odd) or (odd, even) then the pixel must be a green filtered pixel






%pad the image to give some room to work.
padarray(img,[1,1],0,"Both");

%On my machine, this script takes more than 300 minutes for a 3280X3280 Bayer array
for cx = 2:size(colourImg)-1
	for cy = 2:size(colourImg)-1
		for cRGB = 1:3
			if (mod(cx,2) & mod(cy,2))
				colourImg(cx-1,cy-1,3) = img(cx,cy);
				colourImg(cx-1,cy-1,2) = (img(cx,cy-1) + img(cx,cy+1) + img(cx-1,cy) + img(cx+1,cy))/4;
				colourImg(cx-1,cy-1,1) = (img(cx-1,cy-1) + img(cx+1,cy+1))/2;
			else if !(mod(cx,2) | mod(cy,2))
					colourImg(cx-1,cy-1,1) = img(cx,cy);
				colourImg(cx-1,cy-1,2) = (img(cx,cy-1) + img(cx,cy+1) + img(cx-1,cy) + img(cx+1,cy)) / 4;
				colourImg(cx-1,cy-1,3) = (img(cx-1,cy-1) + img(cx+1,cy+1))/2;
			else if mod(cx,2) & !(mod(cy,2))
				colourImg(cx-1,cy-1,2) = img(cx,cy);
				colourImg(cx-1,cy-1,1) = (img(cx-1,cy) + img(cx+1,cy))/2;
				colourImg(cx-1,cy-1,3) = (img(cx,cy-1) + img(cx,cy+1))/2;
			else
				colourImg(cx-1,cy-1,2) = img(cx,cy);
				colourImg(cx-1,cy-1,1) = (img(cx,cy-1) + img(cx,cy+1))/2;
				colourImg(cx-1,cy-1,3) = (img(cx-1,cy) + img(cx+1,cy))/2;
				end 
			end
		end
	end
end
end
