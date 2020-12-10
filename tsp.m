% Example of Traveling Salesman Problem
% solved using genetic algorithm
tStart = tic;
iters = 2000; % number of iterations/ generations
pop_size = 100; % number of chromosomes in a population
genes = 100; % number of genes (cities) in a chromosome

load('xy.mat');

max_fitness = 0;
min_distance = 0;
distances = pdist2(xy, xy);

%% Create the population and initialize it with zeroes
population = zeros(pop_size, genes);
for i = 1:pop_size
    population(i, :) = randperm(genes, genes);
end

%% always have an extra column at the end
population = [population zeros(pop_size,1)];

%% Repeat the process of improving the population
for k = 1:iters

    %% Sum the distance between the cities chosen to visit in each population
     for i = 1:pop_size
        % calculate the distance between two consecutive locations
        population(i, genes+1) = get_distance(population(i, :), distances);
     end

    %% elite, keep best 2
    population = sortrows(population, genes+1);
    min_distance = population(1, genes+1);
    max_fitness = 1/min_distance;
    population_new = zeros(pop_size, genes);
    population_new(1:2,:) = population(1:2,1:genes);
    population_new_num = 2;
    
    %% Selects two parent chromosomes and applies crossover/mutation to form a new offspring
    while (population_new_num < pop_size)
        %% Run the selection algorithm to choose two parent chromosomes
        weights= population(:,genes+1)/sum(population(:,genes+1));
        % 2, 2 = the size of the tournament, number of rounds
%         tour1_winner = tour(population, pop_size, 2, 2);
%         tour2_winner = tour(population, pop_size, 2, 2);
        choice1 = roulette(weights);
        choice2 = roulette(weights);
        temp_chromosome_1 = population(choice1, 1:100);
        temp_chromosome_2 = population(choice2, 1:100);
%         temp_chromosome_1 = tour1_winner(:, 1:100);
%         temp_chromosome_2 = tour2_winner(:, 1:100);
        
        %% X prob 0.7 and random pick two slice points for OX
        if (rand < 0.01)

            % do the OX for copying a subset of parent 1 to a child
            offspring1 = OX(temp_chromosome_1, temp_chromosome_2);

            % repeat but with subset of parent 2
            offspring2 = OX(temp_chromosome_2, temp_chromosome_1);

            temp_chromosome_1 = offspring1;
            temp_chromosome_2 = offspring2;
        end
        
        %% mutation prob 0.2 and random genes to swap places
        if (rand < 0.4)
          temp_chromosome_1 = mutate(temp_chromosome_1);
        end
        
        % swap cities in the 2nd offspring
        if (rand < 0.4)
          temp_chromosome_2 = mutate(temp_chromosome_2);
        end
        
        %% Add the offsprings to the population if the distance is smaller than the global min
        dist1 = get_distance(temp_chromosome_1, distances);
        dist2 = get_distance(temp_chromosome_2, distances);
        % being picky here about what offsprings are to be added to the
        % population (only similar or better ones are accepted)
        if (dist1 <= min_distance)
            population_new_num = population_new_num + 1;
            population_new(population_new_num,:) = temp_chromosome_1;
        end
        if (population_new_num < pop_size && dist2 <= min_distance)
            population_new_num = population_new_num + 1;
            population_new(population_new_num,:) = temp_chromosome_2;
        end
    end
    
    %% Swap the old population with the new one
    population(:,1:genes) = population_new;
    
%      fprintf('Min d:  %f\n', min_distance);
%      fprintf('Gen: %i\n\n', k);
end
%% At the end sum the values again and choose the best chromosome
%  The one with the highest value acummulated from the items chosen
for i = 1:pop_size
    % calculate the distance between two consecutive locations
    population(i,genes+1) = get_distance(population(i, :), distances);
end

population = sortrows(population,genes+1);
minDist = population(1,genes+1);
optRoute = population(1, 1:genes);
tEnd = toc(tStart);

%% Print the best fitness value, execution time amd plot the route diagram
fprintf('Execution time: %.2f s\n', tEnd);
fprintf('Max fitness: %.3f\n', 1/minDist*100);

figure('Name','TSP_GA | Results','Numbertitle','off');
subplot(2,2,1);
pclr = ~get(0,'DefaultAxesColor');
plot(xy(:,1),xy(:,2),'.','Color',pclr);
title('City Locations');
subplot(2,2,2);
rte = optRoute([1:100 1]);
plot(xy(rte,1),xy(rte,2),'r.-');
title(sprintf('Total Distance = %1.4f',minDist));