%% Not finished, just experimenting
function index = binarySearchMod(array, elem, left, right)
    ind = -1;
    while (left <= right)
        mid = left + (right-left)/2;
        
        if (array(:, mid) > elem)
            ind = mid;
            break
        elseif (array(:, mid) < elem)
             right = mid+1;
        end
    end
    index = ind;
        