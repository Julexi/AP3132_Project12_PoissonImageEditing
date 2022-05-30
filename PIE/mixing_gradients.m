function result = mixing_gradients(tgt_im,src_im,msk_im)

msk_im=mat2gray(msk_im);
msk_im=msk_im==1; %make the mask a 0 or 1 image
n=size(find(msk_im==1),1); %find the number of unknown pixels

tgt_im=double(tgt_im);
src_im=double(src_im); %add accuracy

msk_pixel_num=zeros(size(msk_im)); %convert mask to a 1D array
result=tgt_im; %initialize, paste the calculated area to target image
msk_index=0;
for x=1:size(msk_pixel_num,1)
    for y=1:size(msk_pixel_num,2)
        if msk_im(x,y)==1   %if the pixel is unknown, in the white area
            msk_index=msk_index+1;
            msk_pixel_num(x,y)=msk_index;  %convert mask(x,y) to a 1D array
        end
    end
end

for i=1:3 %loop through RGB channel
    sparse=5;
   
    A=spalloc(n,n,n*sparse);  %initialize sparse matrix, at most have n*5 nonzero elements in A matrix
    
    B=zeros(n,1);  %initialize column matrix
    
    x_derivation=[-1 1];
    y_derivation=[-1;1]; 
    
    x_tgt_derivation=conv2(tgt_im(:,:,i),x_derivation, 'same');
    y_tgt_derivation=conv2(tgt_im(:,:,i),y_derivation, 'same');
    tgt_derivation=sqrt(x_tgt_derivation.^2+y_tgt_derivation.^2); %the variation of target image 
    
    x_src_derivation=conv2(src_im(:,:,i),x_derivation, 'same');
    y_src_derivation=conv2(src_im(:,:,i),y_derivation, 'same');
    src_derivation=sqrt(x_src_derivation.^2+y_src_derivation.^2);  %the variation of source image
    
    tgt_derivation=tgt_derivation(:);
    src_derivation=src_derivation(:);  % make them into 1D array
    
    g_x_final=x_src_derivation(:);
    g_y_final=y_src_derivation(:);    %initialize the final gradient with the source gradient
    
    g_x_final(abs(tgt_derivation)>abs(src_derivation))=x_tgt_derivation(tgt_derivation>src_derivation);
    g_y_final(abs(tgt_derivation)>abs(src_derivation))=y_tgt_derivation(tgt_derivation>src_derivation); %take the value of bigger one
    
    g_x_final=reshape(g_x_final,size(src_im,1),size(src_im,2));
    g_y_final=reshape(g_y_final,size(src_im,1),size(src_im,2)); %back to 2D
    
    grad=conv2(g_x_final,x_derivation, 'same');
    grad=grad+conv2(g_y_final,y_derivation, 'same');
    msk_index=0;
    for x=1:size(msk_pixel_num,1)
        for y=1:size(msk_pixel_num,2)
            if msk_im(x,y)==1
                msk_index=msk_index+1;
                A(msk_index,msk_index)=4; % diagnal always equal to 4
                
                if msk_im(x-1,y)==0 % if the left pixel of current pixel is known
                    B(msk_index)=tgt_im(x-1,y,i); % B takes the value of target image
                else % if unknown 
                    A(msk_index,msk_pixel_num(x-1,y))=-1; %A matrix will A(x-1,y) will be set to -1
                end
                if msk_im(x+1,y)==0 %same check for right pixel
                    B(msk_index)=B(msk_index)+tgt_im(x+1,y,i); 
                else 
                    A(msk_index,msk_pixel_num(x+1,y))=-1; 
                end
                if msk_im(x,y-1)==0 %pixel below
                    B(msk_index)=B(msk_index)+tgt_im(x,y-1,i); 
                else 
                    A(msk_index,msk_pixel_num(x,y-1))=-1;
                end
                if msk_im(x,y+1)==0 %pixel above
                    B(msk_index)=B(msk_index)+tgt_im(x,y+1,i); 
                else 
                    A(msk_index,msk_pixel_num(x,y+1))=-1; 
                end
                
                B(msk_index)=B(msk_index)-grad(x,y);
                
            end
        end
    end
   
    X=A\B; %solve the linear system of equation
 
    for msk_index=1:length(X)
        [index_x,index_y]=find(msk_pixel_num==msk_index);
        result(index_x,index_y,i)=X(msk_index);  %reshape X to 2D image
    end
end

result=uint8(result);

end

