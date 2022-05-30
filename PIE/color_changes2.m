function result = color_changes2(src_im,tgt_im, background, msk_im)

msk_im=msk_im==1;
tgt_im=double(tgt_im);
src_im=double(src_im); % for higher precision

result=background; %initialize the result as target image

n=size(find(msk_im==1),1); %find the number of unknown pixels

msk_pixel_num=zeros(size(msk_im)); %convert mask to 1D array

msk_index=0;
for x=1:size(msk_pixel_num,1)
    for y=1:size(msk_pixel_num,2)
        if msk_im(x,y)==1 
            msk_index=msk_index+1;
            msk_pixel_num(x,y)=msk_index;  %convert mask(x,y) to 1D array
        end
    end
end
grad_gradients=[0 1 0; 1 -4 1; 0 1 0];


sparse=5;

A=spalloc(n,n,n*sparse);  %initialize sparse matrix, at most have n*5 nonzero elements in A matrix

B=zeros(n,1); % initialize column vector

grad=conv2(src_im(:,:),-grad_gradients, 'same'); %calculate the gradients of source image
msk_index=0;
for x=1:size(msk_pixel_num,1)
    for y=1:size(msk_pixel_num,2)
        if msk_im(x,y)==1
            msk_index=msk_index+1;
            A(msk_index,msk_index)=4; % diagnal always equal to 4
            
            if msk_im(x-1,y)==0 % if the left pixel of current pixel is known
                B(msk_index)=tgt_im(x-1,y); % B takes the value of target image
            else % if unknown 
                A(msk_index,msk_pixel_num(x-1,y))=-1; %A matrix will A(x-1,y) will be set to -1
            end
            if msk_im(x+1,y)==0 %same check for right pixel
                B(msk_index)=B(msk_index)+tgt_im(x+1,y); 
            else 
                A(msk_index,msk_pixel_num(x+1,y))=-1; 
            end
            if msk_im(x,y-1)==0 %pixel below
                B(msk_index)=B(msk_index)+tgt_im(x,y-1); 
            else 
                A(msk_index,msk_pixel_num(x,y-1))=-1;
            end
            if msk_im(x,y+1)==0 %pixel above
                B(msk_index)=B(msk_index)+tgt_im(x,y+1); 
            else 
                A(msk_index,msk_pixel_num(x,y+1))=-1; 
            end
            
            B(msk_index)=B(msk_index)+grad(x,y); %update the B vector with the gradlacian value
            
        end
    end
end

X=A\B; %solve the linear system of equation
for msk_index=1:length(X)
    [index_x,index_y]=find(msk_pixel_num==msk_index);
    result(index_x,index_y)=X(msk_index); %reshape X to 2D image
end 


result=uint8(result);

end
