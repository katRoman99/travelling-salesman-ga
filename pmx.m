function child = pmx(parent1, parent2)
    point1 = randi(100);
    point2 = randi(100);
    
    offspring = zeros(1, 100);
    
    start_index = min([point1 point2]);
    end_index = max([point1 point2]);
    
    % map the values between the start and end indexes
    
    
    key_set = parent2(:, start_index:end_index);
    value_set = parent1(:, start_index:end_index);
    map = containers.Map(key_set, value_set);
    
    % copy the selected part from the 2nd parent to a child
    offspring(:, start_index:end_index) = parent2(:, start_index:end_index);
    
    m = 1;
    
    % start filling in the rest of the offspring genes, getting the mapped
    % values if offspring already contains the value from a parent
    while (m < start_index)
        elem = parent1(:, m);
        while (ismember(elem, offspring) == 1)
%             key_set
%             value_set
%             elem
            temp = elem;
            elem = map(temp);
        end
        offspring(:, m) = elem;
        m = m+1;
    end
    
    m = end_index+1;
    
    while (m < 101)
       elem = parent1(:, m);
       while (ismember(elem, offspring) == 1)
           temp = elem;
           elem = map(temp);
       end
       offspring(:, m) = elem;
       m = m+1;
    end
    
    child = offspring;
    
    