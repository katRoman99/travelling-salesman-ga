function swapped = swap(chromosome, index1, index2)

    s = chromosome(:, :);
    temp = s(:, index1);
    s(:, index1) = s(:, index2);
    s(:, index2) = temp;
    
    swapped = s;