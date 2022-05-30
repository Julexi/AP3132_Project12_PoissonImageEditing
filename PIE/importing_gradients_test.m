%% importing gradients/faces
source='kenneth2.jfif';
target='willem9.jfif';
im_source = imread(source);          
im_target = imread(target);   
[im_mask,u,v]=roipoly(im_source); %select the area mask
position_y=169;
position_x=163; % specify the position in im_target image

[r,c] = find(im_mask == 1);  % extract mask (crop image)                    
maxHeight = max(r) - min(r);                    
maxWidth= max(c) - min(c);                 
src_crop = imcrop(im_source,[min(c) min(r) maxWidth maxHeight]);  % crop the source image
[hh ww dd] = size(src_crop);

msk_im=zeros(hh,ww);
msk_im(:,:)=imcrop(im_mask,[min(c) min(r) maxWidth maxHeight]);
msk_im(1,:)=0;
msk_im(end,:)=0;
msk_im(:,1)=0;
msk_im(:,end)=0;
se = strel('disk',5);
msk_im = imerode( msk_im,se);
%use only the ROI
tgt(:,:,1)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 1 );
tgt(:,:,2)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 2 );
tgt(:,:,3)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 3 );

result = importing_gradients(tgt,src_crop,msk_im); %using importing gradients

im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 1 ) = result(:,:,1);
im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 2 ) = result(:,:,2);
im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 3 ) = result(:,:,3);
imshow(im_target)
%% dog 1
clc
clear all

source='dog2.jfif';
target='water1.jfif';
im_source = imread(source);          
im_target = imread(target);   
[im_mask,u,v]=roipoly(im_source); %select the area mask
position_y=358;
position_x=130; % specify the position in im_target image

[r,c] = find(im_mask == 1);  % extract mask (crop image)                    
maxHeight = max(r) - min(r);                    
maxWidth= max(c) - min(c);                 
src_crop = imcrop(im_source,[min(c) min(r) maxWidth maxHeight]);  % crop the source image
[hh ww dd] = size(src_crop);

msk_im=zeros(hh,ww);
msk_im(:,:)=imcrop(im_mask,[min(c) min(r) maxWidth maxHeight]);
msk_im(1,:)=0;
msk_im(end,:)=0;
msk_im(:,1)=0;
msk_im(:,end)=0;
se = strel('disk',5);
msk_im = imerode( msk_im,se);
%use only the ROI
tgt(:,:,1)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 1 );
tgt(:,:,2)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 2 );
tgt(:,:,3)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 3 );

result = importing_gradients(tgt,src_crop,msk_im);

im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 1 ) = result(:,:,1);
im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 2 ) = result(:,:,2);
im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 3 ) = result(:,:,3);
imshow(im_target)

%% close insertion
clc
clear all

source='dog2.jfif';
target='water1.jfif';
im_source = imread(source);          
im_target = imread(target);   
[im_mask,u,v]=roipoly(im_source); %select the area mask
position_y=272;
position_x=454; % specify the position in im_target image

[r,c] = find(im_mask == 1);  % extract mask (crop image)                    
maxHeight = max(r) - min(r);                    
maxWidth= max(c) - min(c);                 
src_crop = imcrop(im_source,[min(c) min(r) maxWidth maxHeight]);  % crop the source image
[hh ww dd] = size(src_crop);

msk_im=zeros(hh,ww);
msk_im(:,:)=imcrop(im_mask,[min(c) min(r) maxWidth maxHeight]);
msk_im(1,:)=0;
msk_im(end,:)=0;
msk_im(:,1)=0;
msk_im(:,end)=0;
se = strel('disk',5);
msk_im = imerode( msk_im,se);
%use only the ROI
tgt(:,:,1)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 1 );
tgt(:,:,2)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 2 );
tgt(:,:,3)=im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 3 );

result = importing_gradients(tgt,src_crop,msk_im);

im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 1 ) = result(:,:,1);
im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 2 ) = result(:,:,2);
im_target( position_y:(position_y+hh-1), position_x:(position_x+ww-1), 3 ) = result(:,:,3);
imshow(im_target)