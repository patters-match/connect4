# Connect 4 PvP : a one-line game for ZX Spectrum
#
# by Digital Prawn and Einar Saukas, with additional suggestions by Dr BEEP
#
# http://reptonix.awardspace.co.uk/sinclair/oneliners/connect4-pvp.htm
#
# comments by patters
#
#       let n=23620
#                                                          red player starts
        let p=2
#                                                          set paper to blue
#       poke n+73,8
        poke 23693,8
        cls
#                                                          real game grid array 7X * 6Y = 42 positions
#
#                                                          this program uses a one dimensional array
        dim t(65)
#                                                            t(1)           = stores position of last token to be played
#                                                            t(2) to t(8)   = stores positions of tokens in the last line that was checked for length, so...
#                                                            t(5)          != 0 means that a game has been won because the line is length >=4
#
#                                                            t(10) to t(16) = top row
#                                                            t(18) to t(24) = second row
#                                                            t(26) to t(32) = third row
#                                                            t(34) to t(40) = fourth row
#                                                            t(42) to t(48) = fifth row
#                                                            t(50) to t(56) = bottom row
#
#                                                            t(58) to t(65) = spare row to prevent a "3 Subscript Wrong" error when position below a token is checked in @tokenfall
#
#                                                          very neat: the unused value per row - t(17), t(25), t(33), etc. - prevents line detections
#                                                          wrapping from one side of the grid to the other since the check will always hit an empty index
#
#                                                          tokens are stored as player ink colour (2 or 6)
#
@drawgrid:
        for x=1 to 6
            for y=2 to 8
#                                                          winning line of tokens will be set to flashing if found in grid array (their value will be 8)
                print at 20,y*3;y-1; paper t(x*8+y); flash t(x*8+y)=8; \
                      at x*3-1,y*3;"  "; \
                      at x*3,y*3;"  "
            next y
@newturn:
#                                                          increment move counter (starts at 7, is 49 when all 42 tokens have been played)
#                                                          BASIC will continue to increment x even though its original for loop has finished
        next x
#                                                          if there are moves left (move counter != 49) and no one has yet won
#       if 49=x=t(5) then \
#                                                          in a one-liner every statement after an if will be ignored if the condition is false
#                                                          so we need to invert the logic here, also added brackets to show enumeration order
        if (49=x)<>t(5) then goto @end
        border p
#                                                          paints the lower screen to match the current border colour
        input '
@userinput:
        let b=code inkey$-47
#                                                          invalid column selected
#       poke (b<2 or b>8)*n,14
        if (b<2 or b>8) then goto @userinput
#                                                          selected column is full
#       poke (t(b+8)>0)*n,14
        if (t(b+8)>0) then goto @userinput
#                                                          vertical position of token (y print coord)
        let a=0
@tokenfall:
        beep .1,12-a
#                                                          delete the last position (in blue if the token has entered the top row), then draw the new token position
        print paper a=0;at a-1,b*3;"  "; \
                        at a,b*3;"  "; paper p; \
                        at a+2,b*3;"  "; \
                        at a+3,b*3;"  "
#                                                          next row
        let a=a+3
        let k=a*8/3+b
#                                                          if space below token is empty and token is not yet at the bottom row
#                                                          to stop t(k+8) failing for the bottom row, the grid array simply has an additional spare row                                                  
#       poke (t(k+8)=0)*(a<18)*n,18
        if t(k+8)=0 and (a<18) then goto @tokenfall
#                                                          record the player's token ink colour in the grid array
        let t(k)=p
#
#                                                          check for four or more tokens in a row...
#                                                          consider the array indices for all game positions:
#
#                                                           :-----+-----+-----+-----+-----+-----+-----:
#                                                           | 10  | 11  | 12  | 13  | 14  | 15  | 16  |
#                                                           :-----+-----+-----+-----+-----+-----+-----:
#                                                           | 18  | 19  | 20  | 21  | 22  | 23  | 24  |
#                                                           :-----+-----+-----+-----+-----+-----+-----:
#                                                           | 26  | 27  | 28  | 29  | 30  | 31  | 32  |
#                                                           :-----+-----+-----+-----+-----+-----+-----:
#                                                           | 34  | 35  | 36  | 37  | 38  | 39  | 40  |
#                                                           :-----+-----+-----+-----+-----+-----+-----:
#                                                           | 42  | 43  | 44  | 45  | 46  | 47  | 48  |
#                                                           :-----+-----+-----+-----+-----+-----+-----:
#                                                           | 50  | 51  | 52  | 53  | 54  | 55  | 56  |
#                                                           :-----+-----+-----+-----+-----+-----+-----:
#
#                                                          for horizontal lines, tokens are stored 1 index position apart in the array
#                                                          for vertical lines, tokens are stored 8 index positions apart in the array
#                                                          for rising diagonals, tokens are stored 7 index positions apart in the array
#                                                          for falling diagonals, tokens are stored 9 index positions apart in the array
#
#                                                          so four types of line to check
        for j=1 to 4
#                                                          start line check
            let l=0
#                                                          set the array index delta d for the four cases we're checking (1, 7, 8, 9)
            let d=j+5*(j>1)
#                                                          for each line there are two directions to check
            for e=0 to 1
#                                                          start postion (last token played)
                let m=k
#                                                          iterate along the line to be tested
@checknext:
                let l=l+1
#                                                          store checked token(s) in the unused 'first row' of the grid array
                let t(l)=m
#                                                          m=m+d or m=m-d depending on the direction e
#                                                          fewer characters than using 'for e=-1 to 1 step 2'
                let m=m-d+2*d*e
#                                                          if the next token in the line being checked is the same colour then check the next
#               poke (t(m)=p)*n,29
                if t(m)=p then goto @checknext
            next e
#                                                          if there are four or more tokens in a row
            for f=1 to l*(l>4)
#                                                          change the winning line token positions in the grid array to value 8 so they can be flashed
                let t(t(f))=8
                beep .1,f*3
            next f
        next j
#                                                          player is either 2 (red) or 6 (yellow), alternate between those two states
        let p=8-p
#       poke n,6+4*(t(5)=0)
        if t(5)=0 then goto @newturn
#                                                          somebody won
        goto @drawgrid
@end:
