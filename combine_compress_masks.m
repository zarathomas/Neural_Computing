%%This code reads in individual nuclei masks (from the 'stage1_train'
%%folder), combines them to form a single mask per training image, resizes the mask to
%%227x227, and exports the mask to the 'stage_1_train_labels' folder. 

clear all; 
cd /Users/appy/Documents/Coursework/City_MSC/Neural_Networks_Coursework/stage1_train;

%Read in the folder names. Each folder represents a single training image, and has
%a sub-folder with masks. 
masterfolder = dir();
%Remove unnecessary folder names 
masterfolder(ismember( {masterfolder.name}, {'.', '..', '.DS_Store'})) = []; 

%Loop through each training image folder
for i = 1:length(masterfolder) 
    master_name_orig = masterfolder(i).name; 
    %Enter the 'masks' sub-folder and store names of each mask
    master_name = strcat(master_name_orig,'/masks');
    myfolder = dir(master_name);
    %Remove non-mask file names 
    myfolder(ismember( {myfolder.name}, {'.', '..'})) = []; 
    %Read in the first mask
    mask_one_url = strcat(master_name,"/",myfolder(1).name);
    mask_one_url = char(mask_one_url); 
    mask_final = imread(mask_one_url);
    %Loop through the rest of the masks 
    for j  = 2:length(myfolder)
        %Read in the mask
        mask_next_url = strcat(master_name,'/',myfolder(j).name);
        mask_next_url = char(mask_next_url); 
        mask_next = imread(mask_next_url);
        %Combine the mask (by adding it to the previous mask image)
        mask_final = mask_final + mask_next;
    end 
    %Resize the mask image to 227 x 227
    mask_resized = imresize(mask_final, [227 227]);
    %Write the resized mask image in the 'stage1_train_labels' folder
    file_name = strcat(master_name_orig,'_label.png')
    img_path = '/Users/appy/Documents/Coursework/City_MSC/Neural_Networks_Coursework/stage1_train_labels'
    imwrite(mask_resized, fullfile(img_path, file_name));
end


