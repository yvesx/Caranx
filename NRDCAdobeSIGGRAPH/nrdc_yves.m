%% Read files
my_dir = './sbux/';
my_out_dir = './sbux_out/';
files = dir('./sbux/');

fileIndex = find(~[files.isdir]);

counter = 0;
for i = 1:length(fileIndex)-1
    for j = i+1:length(fileIndex)
        filename = strcat(my_out_dir,num2str(i),'-',num2str(j),'.jpg');
        counter = counter + 1;
        if (counter > 100)
            break;
        end
        Src_path = strcat(my_dir, files(fileIndex(i)).name);
        Ref_path = strcat(my_dir, files(fileIndex(j)).name);
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
        %% Uncomment the next line to prefer determinism over speed.
        % NRDC_Options.isParallelized = false; 
        %% Run NRDC (This version is optimized for best quality, not for speed).
        if (~exist('per_pixel_constraints', 'var') || isempty(per_pixel_constraints))
            tic
            [DCF, ~, ~, AlignedRef] = nrdc(Src, Ref, NRDC_Options);
            toc % 9.5 seconds for the attached example (using the parallelized version on 2.3GHz Intel Core i7 (2820qm) MacBook Pro)
        else % Run with per pixel-constraint
            tic
            [DCF, ~, ~, AlignedRef] = nrdc(Src, Ref, NRDC_Options, per_pixel_constraints);
            toc % 8.6 seconds for the attached example (using the parallelized version on 2.3GHz Intel Core i7 (2820qm) MacBook Pro)
        end
        %% Display the result:
        if isempty(DCF)
            disp('No matching has been found.')
        else
            % Show aligned reference:
            imwrite(AlignedRef,filename);
        end
    end
end