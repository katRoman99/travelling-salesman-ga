% Selection Algorithm. A set of weights represents the probability of selection of each
% chromosome in a group of choices. It returns the index of the chosen chromosome.
% ---------------------------------------------------------
function choice = roulette(weights)
  accumulation = cumsum(weights);
  p = rand();
  
  left = 1;
  right = length(accumulation);
  
  % using binary search for better time complexity
  % saves 1s of execution time at 2000 iters, 50 pop_size
  while (right - left > 1)
      mid = floor((left+right)/2);
      
      if (accumulation(mid) > p)
          right = mid;
      else
          left = mid;
      end
  end
  choice = left;
          
%   for index = 1 : length(accumulation)
%     if (accumulation(index) > p)
%       chosen_index = index;
%       break;
%     end
%   end
%   choice = chosen_index;