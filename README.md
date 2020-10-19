# GAME Wheel of Fortune


* This game is based on the famous British TV show Wheel of Fortune
https://en.wikipedia.org/wiki/Wheel_of_Fortune_(British_game_show)

## Rules of the game:
* There are 4 words/phrases in total. 
Select one from them at random and a template which shows only how many letters in 
the word/phrase by blank spaces. 
* A player guesses one letter at a time. 
* If the player gets a letter which is contained in the word/phrase, all the letters should be shown up. For example, the player’s guess is X. All X in the selected word/phrase should show up. 
* If the player does not get a letter which is contained in the selected word/phrase, then the he or she just used one of his or her 5 GOES. 
* If the player gets all the letters in the selected word/phrase that means the selected word/phrase has been revealed. Then another word/phrase from the remaining ones is selected randomly. 
* If the player gets all the 4 words/phrases revealed within 5 GOES, he or she wins. If not, the player fails. 

## State diagram:

 ![image](https://github.com/HM2468/GAME-WOF/blob/main/wof.png)




## To run the TDD test:
```
$ rspect wad_wof_spec_01.rb
```

To start the game:
```
$ ruby wad_wof_run_01.rb
```


