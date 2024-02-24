# Trivia Game Flutter App Documentation
## Overview
This documentation provides a comprehensive guide to the Flutter-based Trivia Game application. The app comprises several key classes and screens, each serving specific functions within the game.

# QuestionsProvider Class
## Description
QuestionsProvider is a class responsible for managing trivia questions in the game. It facilitates question navigation, timer resetting, and retrieval of information about the current question.

## Properties
_questions: List of QuestionsModel instances representing trivia questions.
_currentIndex: Integer indicating the index of the current question.
_countdownDuration: Integer representing the countdown duration for each question.

## Methods
- moveToNextQuestion()
Moves to the next question if available.

- resetCountdown()
Resets the countdown duration to the default value.

- resetQuestionIndex()
Resets the question index to 0.

# GetStartedScreen Class
## Description
GetStartedScreen is an introductory screen welcoming users to the trivia game. It plays an introductory sound and provides a "Start Now" button to initiate the game.

## Properties
- audioPlayer: An AudioPlayer instance for playing sounds.
- Methods
playSong()
Plays the introductory sound.

# GameScreen Class
## Description
GameScreen represents the primary game interface where users interact with trivia questions. It includes a timer, question display, and options for users to select.

## Properties
- selectedOption: String representing the currently selected option.
- timer: Timer managing question time limits.
- gameTimer: Timer tracking the overall game time.
- correctCount: Integer tracking the number of correct answers.
- wrongCount: Integer tracking the number of incorrect answers.
- elapsedSeconds: Integer representing the total time elapsed.
- audioPlayer: An AudioPlayer instance for playing quiz sounds.
  
## Methods
- playSong()
Plays the quiz sound.

- startGameTimer()
Starts the game timer, updating elapsedSeconds every second.

- startQuestionTimer()
Starts the timer for each trivia question, moving to the next question if time runs out.

- handleOptionSelected(selectedOption)
Handles the selection of a trivia option, updating the state accordingly.

- cancelTimer()
Cancels the current timer.

- onRestart(context)
Restarts the game by resetting variables, question index, and timers.

- dispose()
Disposes of timers and audio players when the screen is disposed.

- moveToNextQuestion()
Moves to the next question, checking the selected option's correctness.

- checkIfOptionIsCorrect(selectedOption, options)
Checks if the selected option is correct.

- formatTime(seconds)
Formats elapsed seconds into a readable time format.

- onAnsweredCorrectly(isCorrect)
Updates the state when an answer is correct.

- onAnsweredWrongly(isCorrect)
Updates the state when an answer is incorrect.

# GameResult Class
## Description
GameResult displays the results of the trivia game, including the total time used, correct and incorrect counts, and a congratulatory message.

## Properties
- audioPlayer: An AudioPlayer instance for playing a finishing sound.
- 
## Methods
- formatTime(seconds)
Formats elapsed seconds into a readable time format.

- playSong()
Plays the finishing sound.

- dispose()
Disposes of the audio player when the screen is disposed.

- build(context)
Builds the UI for the GameResult screen.
