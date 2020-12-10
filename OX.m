% function performing an ordered crossover between two
% parent chromosomes

function ch = OX(parent1, parent2)
    point1 = randi(100);
    point2 = randi(100);
    
    offspring = zeros(1, 100);
    
    start_index = min([point1 point2]);
    end_index = max([point1 point2]);
    
    % copy the selected part from the 1st parent to a child
    offspring(:, start_index:end_index) = parent1(:, start_index:end_index);
    
    % then copy the parent2 values to the child while maintaining
    % the original order and no repetition
    
    difference = setdiff(parent2, parent1(:, start_index:end_index));
    
    % copy before the start index
    n = 1;
    m = 1;
    while n < start_index
        offspring(:, n) = difference(:, m);
        n = n+1;
        m = m+1;
    end
    
    % copy after the end index
    n = end_index+1;
    
    while n < 101
        offspring(:, n) = difference(:, m);
        n = n+1;
        m = m+1;
    end
    ch = offspring;
    
    