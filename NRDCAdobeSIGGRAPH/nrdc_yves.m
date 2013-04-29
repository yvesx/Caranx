%% Read files
my_dir = './sbux/';
my_out_dir = './sbux_out/';
files = dir('./sbux/');
counter_thres = 10000;
diversity_counter_thres = 7;
fileIndex = find(~[files.isdir]);

counter = 0;
for i = 8:20
    diversity_counter = 0;
    for j = i+1:length(fileIndex)
        disp(strcat(num2str(i),'-',num2str(j)));
        filename = strcat(my_out_dir,num2str(i),'-',num2str(j),'.jpg');
        counter = counter + 1;
        if (counter > counter_thres || diversity_counter > diversity_counter_thres)
            break;
        end
        Src_path = strcat(my_dir, files(fileIndex(j)).name);
        Ref_path = strcat(my_dir, files(fileIndex(i)).name);
        Src             = double(imread(Src_path)) / 255.0;
        Ref             = double(imread(Ref_path)) / 255.0;
        %% Reduce size if source image is too big
        rf = max(max(size(Src)))  / 640;
        if (rf > 1)
            disp('source image is too big. resize automatically.')
            Src = imresize(Src, 1.0/rf);
            Ref = imresize(Ref, 1.0/rf);
        end
        %% Set an empty options struct
        NRDC_Options = [];
        [DCF, ~, ~, AlignedRef] = nrdc(Src, Ref, NRDC_Options);
        %% Display the result:
        if isempty(DCF)
            disp('No matching has been found.')
        else
            % Show aligned reference:
            diversity_counter = diversity_counter + 1;
            imwrite(AlignedRef,filename);
        end
    end
end