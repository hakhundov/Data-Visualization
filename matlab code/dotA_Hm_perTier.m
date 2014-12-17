%% Calculate heatmap

%initialize matrices
heatmap_normal = zeros(max(x),max(y));
heatmap_high = zeros(max(x),max(y));
heatmap_veryhigh = zeros(max(x),max(y));
heatmap_pro = zeros(max(x),max(y));

%scan through data
for j = 2: length(x)
    if strcmp(tier(j), '"Normal"')
         heatmap_normal(x(j), y(j)) = heatmap_normal(x(j), y(j)) + 1;
    elseif strcmp(tier(j), '"High"')
         heatmap_high(x(j), y(j)) = heatmap_high(x(j), y(j)) + 1;
    elseif strcmp(tier(j), '"VeryHigh"')
         heatmap_veryhigh(x(j), y(j)) = heatmap_veryhigh(x(j), y(j)) + 1;
    elseif strcmp(tier(j), '"Pro"')
         heatmap_pro(x(j), y(j)) = heatmap_pro(x(j), y(j)) + 1;
    end
end

%% normilize & scale heatmaps

heatmap_normal = heatmap_normal / max(heatmap_normal(:)); 
heatmap_high = heatmap_high / max(heatmap_high(:));
heatmap_veryhigh = heatmap_veryhigh / max(heatmap_veryhigh(:));
heatmap_pro = heatmap_pro / max(heatmap_pro(:));

%scale by 40
heatmap_normal = ceil(heatmap_normal * 40); 
heatmap_high = ceil(heatmap_high * 40); 
heatmap_veryhigh = ceil(heatmap_veryhigh * 40); 
heatmap_pro = ceil(heatmap_pro * 40); 

%save the heatmap matrix to a csv file
%csvwrite('heatmap.csv',heatmap)

%apply the Canny edge algorithm
heatmap_pro = edge(heatmap_pro,'canny'); 

%apply a 4x4 median filter
%heatmap_veryhigh = medfilt2(heatmap_veryhigh, [4 4]);


%% Transform the heatmat matrix into a table of {x,y,v}
%We do it manually here for every heat map. But eventually should be
%automated

    [rows,cols] = size(heatmap_pro);
    table = zeros(rows * cols,3);
    count = 1;

    for j = 1: rows
        for i = 1: cols
            table(count,1) = i;
            table(count,2) = j;
            table(count,3) = heatmap_pro(j,i);
            count = count + 1; 
        end
    end

csvwrite('HM_pro_canny.csv',table)
