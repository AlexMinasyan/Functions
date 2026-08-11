# Functions

This project is meant to assist with code storage and reuse. One can be in any, open up the terminal and run the command to either store a block of code or to insert it a desired line.

This was created to allow one to reuse their code from past projects by having a repository that can be indexed with a **fuzzy finder**. This can be used to save time either finding, rewriting, or prompting to recreate functions that exist. Not only is this time consuming, it may lead to the usage of ideas that are not necessary when coding. If you are unsure how to make something happen, you could index the fuzzy finder with keywords or a description and find a choice from there. 

## How to Use

###### Store Functions
To store a function just run the command
``` 
extract_function [TARGET_FILE] [START_LINE] [END_LINE]
```
This will pull all code between `[START_LINE]` and `[END_LINE]` in the `[TARGET_FILE]` and if it is in the list of accepted langauges, extract the name on its own, else it will prompt you for the name. Then it will prompt you for a description as well as a list of desired keywords. Finally it will store it in the CSV file.

###### Use Function
To use a function just run the command
```
use_function [TARGET_FILE] [LINE_INSERT]
```
This will open up a fuzzy finder that prompts for name, language, description, and keywords; select one and then it will insert the function into the `[TARGET_FILE]` at line `[LINE_INSERT]`.

## Installation
To install simply put this entire folder somewhere on your computer, its not that important where. Change the following lines to that the path for the functions.csv file:
 - extract_functions.sh: 58
 - use_function.sh: 5
 - use_function.sh: 15
And add an aliases of the following form to your bash or zsh profile
```
alias extract_function='[LOCATION_OF_FOLDER]/extract_functions.sh'
alias use_function='[LOCATION_OF_FOLDER]/use_function.sh'
```





