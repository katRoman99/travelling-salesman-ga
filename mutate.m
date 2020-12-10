function mutated = mutate(chromosome)
    type = randi(3);
    mut = chromosome(:, :);
    
    index1 = randi(100);
    index2 = randi(100);
    index = randi(99);
    
    start_index = min([index1 index2]);
    end_index = max([index1 index2]);
    
    % if type is 1 do the swap mutation
    if (type == 1)
        mut = swap(mut, index1, index2);
    % if type is 2 do the scramble mutation
    elseif (type == 2)
        to_scramble = mut(:, start_index:end_index);
        scramble_len = end_index - start_index + 1;
        for i = 1:scramble_len
            index = randi(scramble_len);
            temp = to_scramble(:, i);
            to_scramble(:, i) = to_scramble(:, index);
            to_scramble(:, index) = temp;
        end
        mut(:, start_index:end_index) = to_scramble;
    % if type is 3 inverse a subset
    else
        to_inverse = mut(:, start_index:end_index);
        mut(:, start_index:end_index) = flip(to_inverse);
    end
    
    mutated = mut;
            