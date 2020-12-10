function distance = get_distance(chromosome, distances)
    distance_cum = 0;

    for j = 1:99
        d = distances(chromosome(:, j), chromosome(:, j+1));
        distance_cum = distance_cum + d; % add the distance to all
    end
    
    distance = distance_cum + distances(chromosome(:, 100), chromosome(:, 1));