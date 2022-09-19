# Connect 4 PvP

An incredible one-liner BASIC program for ZX Spectrum, by [Digital Prawn and Einar Saukas](http://reptonix.awardspace.co.uk/sinclair/oneliners/connect4-pvp.htm).

[![Connect 4 PvP Screenshots](images/c4screens.png "Connect 4 PvP Screenshots")](http://reptonix.awardspace.co.uk/sinclair/oneliners/connect4-pvp.htm)

This is a shining example of functional minimalism in game design, and utter excellence of execution.
The columns are numbered, the border colour shows you whose turn it is, each player presses a number to play their turn.
There are simple sound effects. When the game is won, the winning line flashes on screen.

That this fits into a single screen of BASIC is all the more astonishing. Just seeing that this game existed motivated me to make [my own one-liner game](https://github.com/patters-syno/line).
Though I used some of the coding tricks that this and [other one-liners](http://reptonix.awardspace.co.uk/sinclair/oneliners/) have employed, I just had to fully unpick this to discover how it functioned - which is what you see here.

- **c4.bas** is the original listing unrolled into a ```*.bas``` file with indentations for readibility, which can be built back into the original tap file by [zmakebas](https://github.com/ohnosec/zmakebas).
When lines are wrapped like this, comments cannot be inserted unfortunately - but it does give a good idea of the flow of the program.
- **c4annotated.bas** is this same listing converted chopped into multiple lines, using labels instead of pokes to jump around, with extensive comments to reveal how it all works.
It too can be built by [zmakebas](https://github.com/ohnosec/zmakebas) into a functionally identical listing, though no longer a one-liner.
