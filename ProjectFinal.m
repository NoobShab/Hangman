% Hangman game.

clear all; 
clc;


% 01
% Game entry
fprintf('Welcome to the hangman game!\n\n');

disp('–––––––––––––––––––––––');

fprintf(['About the Hangman Game;\n\n' ...
    '--> A word will be randomly generated. ' ...
    'You will have to guess the letters ' ...
    'of the word.\nUnable to guess the letters' ...
    ' within the limited attempts']);

fprintf(['\n–––––––––––––––––––––––––\n\n' ...
    '%%BONUS%%\nThe first and last letter is ' ...
    'given as a HINT!\n\n']);


name = input('\n Who am I here with today?\n --> ', 's');
fprintf("\nCool, %s. Let's get started!", name);

% 02
% Generating Random Words for the game

% activating the ReadDictionary function 
dict = readDictionary('hangman.txt');
randomIndex = randi(length(dict));
randomWords = lower(dict{randomIndex});

% 03
% Setting the attempts limit

attemptsLimit = length(randomWords);
fprintf(['\n\nTry solving the following word' ...
    ' within || %d || attempts. \nBest of luck ;)\n\n'], attemptsLimit);
attemptsSoFar = 0;
attemptsLeft = attemptsLimit - attemptsSoFar;

% 04
% Initializing the game state

dash = repmat('_',1,length(randomWords)); % repeating the dash 
dash(1) = randomWords(1); % Hint- the first letter
dash(end) = randomWords(end); % Hint - the last letter

% Initializing the spacing between the dashes
displayDash = '';

for i = 1:length(dash)
    displayDash = [displayDash dash(i) ' '];
end

disp(displayDash);
fprintf('\n');

% 05
% Trying to guess the word

guessedLetters = []; % Store the guessed letters

while attemptsLeft > 0 && any(dash == '_')
    % Ask for input
    guessInput = input('What letter do you guess?\n--> ', 's');

    % Normalize the inputs as lowercase
    guess = lower(guessInput(1)); 
    
    if any(~isletter(guessInput)) ||... 
        any(length(guessInput) ~= 1) ||... 
        any(isempty(guessInput))
        
        fprintf(['!!!!!!!!!!!!!!!!!!!!!!!!\n' ...
            'Please try with a SINGLE letter' ...
            '\n!!!!!!!!!!!!!!!!!!!!!!\n']);
        
        continue;
    end 

    % Setting up draw letters that can be matched
    if any(guessedLetters == guess) ||... 
        dash(1) == guess || dash(end) == guess
        
        fprintf(['\noooooooooooooooooooooooo\nAlready guessed ' ...
            ' | %s |. Try any other letter.\nooooooooooooooooooooo\' ...
            'n\n'], guess);

        continue;
    end
    
    % Setting loop to match guess with randomWords
    if any(randomWords == guess)
        fprintf(['\n\n~~~~~~~~~~~~Woah!~~~~~~~~~~~~ \n| %s' ...
            ' | is in the word. Carry on' ...
            '!\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n'], guess);
    
    % Revealing dashes with letters guessed
        for i = 1:length(randomWords)
            if randomWords(i) == guess
                dash(i) = guess;
            end
        end

        % Display updated state with proper spacing
        % By concatenating the values
        displayDash = '';

        for i = 1:length(dash)
            displayDash = [displayDash dash(i) ' '];
        end
        
        disp(displayDash);

    else
        fprintf(['\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n| %s | ' ...
            'is NOT in the word. Try Again.\n' ...
            'xxxxxxxxxxxxxxxxxxxxxxxxxxxx\n\n'], guessInput);

        disp(displayDash);
        attemptsSoFar = attemptsSoFar + 1;

        % decrease the value gradually after failed attempts
        attemptsLeft = attemptsLimit - attemptsSoFar;
    end

    % Show the progress
    fprintf('\nThe attempts you have left: %d\n', attemptsLeft);
    guessedLetters = [guessedLetters guess];
    
end

% 06
% Exiting the game

if ~any(dash == ('_'))
    
    fprintf(['\n>>>>>>>>>>>>>>>>>>>>>>>>>\n' ...
        'Congratulations! You Won.' ...
        '\n>>>>>>>>>>>>>>>>>>>>>>>>\n\n']);

else
    fprintf('\n >___<\n\nYou LOST! The word was %s\n', randomWords);
end
