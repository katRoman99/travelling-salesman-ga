function winner = tour(chromosomes, pop_size, tour_size, rounds)

    candidates = zeros(tour_size, 101);
    local_min = 1000;
    global_min = 1000;
    
    for j = 1: rounds
        for i = 1:tour_size
            choice = randi(pop_size);
            candidates(i, :) = chromosomes(choice, :);
            candidates(i, 101) = chromosomes(i, 101);
            if (candidates(i, 101) < local_min)
                local_winner = candidates(i, :);
                local_min = local_winner(i, 101);
            end
        end
        if (local_winner(:, 101) < global_min)
            global_min = local_winner(:, 101);
            tour_winner = local_winner;
        end
    end
    
    winner = tour_winner;