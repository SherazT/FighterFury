%Sheraz Tariq
%Fighter Fury
%June 14, 2013
%Airplane shooter game that requires the user to survive 30 seconds in an air battle.

%delcare variables
var window : int := Window.Open ("graphics:1024;768")
var background_image : int
var title : int
var intsc : int
var over : int
var gamewon : int
var plane1, plane2 : int
var cloud : int
var y : int
var x : int
var airplane : int
var key : string (1)
var move : int
var move1 : int
var xbullet : int
var ybullet : int
var xbullet1 : int
var ybullet1 : int
var xcloud : int
var ycloud : int
var xcloud1 : int
var ycloud1 : int
var xcloud2 : int
var ycloud2 : int
var xplane1, xplane2, xplane3, xplane4 : int
var yplane1, yplane2, yplane3, yplane4 : int
var gameover, win : boolean
var planeexit1, planeexit2, planeexit3, planeexit4 : boolean
const movedowncloud : int := 5
const moveupbullet : int := 10

%intialise variables
xplane4 := 750
yplane4 := 900
xplane2 := 250
yplane2 := 1000
xplane1 := 750
yplane1 := 900
y := 0
x := 250
move := 0
move1 := 0
ycloud := 900
xcloud := 0
xcloud1 := 250
xcloud2 := 750
ycloud2 := 900
ycloud1 := 900
gameover := false
planeexit1 := false
planeexit2 := false
planeexit3 := false
planeexit4 := false
win := false

%load image from the same folder
plane2 := Pic.FileNew ("plane2.gif")
plane1 := Pic.FileNew ("plane1.gif")
airplane := Pic.FileNew ("Ship00.gif")
background_image := Pic.FileNew ("background.jpg")
cloud := Pic.FileNew ("cloud.jpg")
title := Pic.FileNew ("title.jpg")
intsc := Pic.FileNew ("instructions.jpg")
over := Pic.FileNew ("gameover.jpg")
gamewon := Pic.FileNew ("gamewon.jpg")

%set the background transparent for some images
Pic.SetTransparentColor (airplane, white)
Pic.SetTransparentColor (cloud, white)
Pic.SetTransparentColor (plane1, white)
Pic.SetTransparentColor (plane2, white)

%-----------------------------------------------------------------------------------START OF GAME CODE-----------------------------------------------------------------------------------

loop
    %show the main title image
    Pic.Draw (title, 0, 0, picMerge)
    %get the key from the user
    getch (key)
    %if user presses space then start game, if they press r then show instructions, and if x then close game
    if key = " " then
	exit
	%if the user presses r then the screen will show the instructions page
    elsif key = "r" then
	Pic.Draw (intsc, 0, 0, picMerge)
	%checks if the user has pressed any other button since pressing r
	getch (key)
	%if user presses b then go back to menu title page
	if key = "b" then
	    cls
	    %draw title once again
	    Pic.Draw (title, 0, 0, picMerge)
	end if
	%if the user press x then exit the game
    elsif key = "x" then
	%closes first current window first
	Window.Close (window)
	%closes the turing window secondly
	Window.Close (window)
    end if
end loop

process endgame
    loop
	%start timer for the 30 second wait until game wins
	%if the game is already not won then put the delay
	if win = false then
	    loop
		%30 sec delay
		delay (30000)
		%if game is not lost yet then show win screen
		if gameover = false then
		    cls
		    %show that the game has been won, and game is over
		    win := true
		    gameover := true
		    exit
		end if
	    end loop
	end if
	%show win screen
	Pic.Draw (gamewon, 0, 0, 0)
    end loop
end endgame

fork endgame

process enemy2
    %take x and y coordinates from  plane1 and make the x coordinate a little smaller
    xplane3 := xplane1 - 150
    yplane3 := yplane1
    loop
	%if the airplane is higher then 0 then show airplane
	if yplane3 > 0 then
	    loop
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%sway the airplane to one side
		for sway : 1 .. 300
		    %if airplane has been hit then exit
		    if planeexit3 = true then
			exit
		    end if
		    if gameover = true then
			exit
		    end if
		    %move the airplane down, and move it left
		    yplane3 := yplane3 - 2
		    xplane3 := xplane3 - 2
		    %draw picture of airplane
		    Pic.Draw (plane1, xplane3, yplane3, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane3 + 35, yplane3 + 48, 10, 10, black)
		    %if airplane has been hit then exit
		    if planeexit3 = true then
			exit
		    end if
		    delay (10)
		end for
		%sway airplane other way
		for sway : 1 .. 200
		    %if the plane has been hit then exit the loop, which will eventually lead to the loop being exited and exiting the airplane
		    if planeexit3 = true then
			exit
		    end if
		    %if the game is over then exit the loop so that the plane eventually exits just like the other objects
		    if gameover = true then
			exit
		    end if
		    %decreasing the y value by 2 and increasing the x value by 2 so that the airplane moves downright
		    yplane3 := yplane3 - 2
		    xplane3 := xplane3 + 2
		    %draw airplane with the coordinates altered above and the picMerge is so that the airplane's background is transparent
		    Pic.Draw (plane1, xplane3, yplane3, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane3 + 35, yplane3 + 48, 10, 10, black)
		    %delay 10 milliseconds
		    delay (10)
		    %make the airplane go down faster
		    yplane3 := yplane3 - 2
		    %draw airplane with the coordinates altered above and the picMerge is so that the airplane's background is transparent
		    Pic.Draw (plane1, xplane3, yplane3, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane3 + 35, yplane3 + 48, 10, 10, black)
		    %if the plane has been hit then exit
		    if planeexit3 = true then
			exit
		    end if
		    delay (10)
		end for
		%if plane is hit then exit
		if planeexit3 = true then
		    exit
		end if
		%exit when airplane is below the screen
		exit when yplane3 < -250
	    end loop
	end if
	%if plane is hit then exit
	if planeexit3 = true then
	    exit
	end if
	%reset the value of the y airplane value to 900 so the airplane goes back up and then comes back down
	yplane3 := 900
    end loop
end enemy2

fork enemy2
put " "

process enemy1
    loop
	%if the airplane is higher then 0 then show airplane
	if yplane2 > 0 then
	    loop
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%if plane has been hit then exit
		if planeexit2 = true then
		    exit
		end if
		%sway the airplane to one side
		for sway : 1 .. 200
		    if gameover = true then
			exit
		    end if
		    %if plane has been hit then exit
		    if planeexit2 = true then
			exit
		    end if
		    %move the airplane down, and move it right
		    yplane2 := yplane2 - 1
		    xplane2 := xplane2 + 2
		    %draw picture of airplane
		    Pic.Draw (plane2, xplane2, yplane2, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane2 + 35, yplane2 + 48, 10, 10, black)
		    delay (10)
		end for
		%sway airplane other way
		for sway : 1 .. 300
		    %if plane is hit then exit
		    if planeexit2 = true then
			exit
		    end if
		    if gameover = true then
			exit
		    end if
		    %move the airplane down, and move it left
		    yplane2 := yplane2 - 1
		    xplane2 := xplane2 - 2
		    %draw picture of airplane
		    Pic.Draw (plane2, xplane2, yplane2, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane2 + 35, yplane2 + 48, 10, 10, black)
		    delay (10)
		    yplane2 := yplane2 - 1
		    Pic.Draw (plane2, xplane2, yplane2, picMerge)
		    drawfilloval (xplane2 + 35, yplane2 + 48, 10, 10, black)
		    delay (10)
		    if planeexit2 = true then
			exit
		    end if
		end for
		%if plane is hit then exit
		if planeexit2 = true then
		    exit
		end if
		%exit when airplane is lower than 0
		exit when yplane2 < -150
	    end loop
	end if
	%if plane is hit then exit
	if planeexit2 = true then
	    exit
	end if
	%reset the y value of airplane
	yplane2 := 800
    end loop
end enemy1

fork enemy1
put " "


process enemy5
    loop
	%if airplane has been hit then exit
	if planeexit4 = true then
	    exit
	end if
	%if the airplane is higher then 0 then show airplane
	if yplane4 > 0 then
	    loop
		%if airplane has been hit then exit
		if planeexit4 = true then
		    exit
		end if
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%sway the airplane to one side
		for sway : 1 .. 200
		    %if the game has been over then exit the loop
		    if gameover = true then
			exit
		    end if
		    %if airplane has been hit then exit
		    if planeexit4 = true then
			exit
		    end if
		    %move the airplane down, and move it right
		    yplane4 := yplane4 - 1
		    xplane4 := xplane4 + 2
		    %draw picture of airplane
		    Pic.Draw (plane2, xplane4, yplane4, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane4 + 35, yplane4 + 48, 10, 10, black)
		    delay (10)
		end for
		%sway airplane other way
		for sway : 1 .. 300
		    %if the game has been over then exit the loop
		    if gameover = true then
			exit
		    end if
		    %if airplane has been hit then exit
		    if planeexit4 = true then
			exit
		    end if
		    %move the airplane down, and move it right
		    yplane4 := yplane4 - 1
		    xplane4 := xplane4 - 2
		    %draw picture of airplane
		    Pic.Draw (plane2, xplane4, yplane4, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane4 + 35, yplane4 + 48, 10, 10, black)
		    delay (10)
		    %make the airplane go down faster
		    yplane2 := yplane2 - 1
		    %draw picture of airplane
		    Pic.Draw (plane2, xplane4, yplane4, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane4 + 35, yplane4 + 48, 10, 10, black)
		end for
		%exit when airplane is lower than 0
		exit when yplane4 < -150
	    end loop
	end if
	%if plane is hit then exit
	if planeexit4 = true then
	    exit
	end if
	%reset the y value of airplane
	yplane4 := 900
    end loop
end enemy5

fork enemy5
put " "


process enemy
    loop
	%if airplane has been hit then exit
	if planeexit1 = true then
	    exit
	end if
	%if the airplane is higher then 0 then show airplane
	if yplane1 > 0 then
	    loop
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%if airplane has been hit then exit
		if planeexit1 = true then
		    exit
		end if
		%sway the airplane to one side
		for sway : 1 .. 200
		    %if the game has been over then exit the loop
		    if gameover = true then
			exit
		    end if
		    %if airplane has been hit then exit
		    if planeexit1 = true then
			exit
		    end if
		    %move the airplane down, and move it left
		    yplane1 := yplane1 - 2
		    xplane1 := xplane1 - 2
		    %draw picture of airplane
		    Pic.Draw (plane1, xplane1, yplane1, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane1 + 35, yplane1 + 48, 10, 10, black)
		    delay (10)
		end for
		%sway airplane other way
		for sway : 1 .. 200
		    %if the game has been over then exit the loop
		    if gameover = true then
			exit
		    end if
		    %if airplane has been hit then exit
		    if planeexit1 = true then
			exit
		    end if
		    %move the airplane down, and move it right
		    yplane1 := yplane1 - 2
		    xplane1 := xplane1 + 2
		    %draw picture of airplane
		    Pic.Draw (plane1, xplane1, yplane1, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane1 + 35, yplane1 + 48, 10, 10, black)
		    delay (10)
		    %make the airplane go down faster
		    yplane1 := yplane1 - 2
		    %draw picture of airplane
		    Pic.Draw (plane1, xplane1, yplane1, picMerge)
		    %draw oval on top of it that it used as a marker that the shooting airplane uses in order to destroy itself
		    drawfilloval (xplane1 + 35, yplane1 + 48, 10, 10, black)
		    delay (10)
		end for
		%exit when airplane is lower than 0
		exit when yplane1 < -250
	    end loop
	end if
	%if plane is hit then exit
	if planeexit1 = true then
	    exit
	end if
	%reset the y value of airplane
	yplane1 := 900
    end loop
end enemy

fork enemy
put " "

process cloudwes2
    loop
	%if the cloud is higher than the 0 point then start the loop
	if ycloud2 > 0 then
	    loop
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%the cloud is going to move down 3 pixels at a time
		ycloud2 := ycloud2 - 3
		%draw the cloud, and picMerge command is to merge the picture to the background without copying it, to keep the transparency
		Pic.Draw (cloud, xcloud2, ycloud2, picMerge)
		delay (10)
		%exit when the cloud is 700 pixels below 0
		exit when ycloud2 <= -700
	    end loop
	end if
	%reset the cloud value to 900 so that the cloud repeats the process
	ycloud2 := 900
    end loop
end cloudwes2

fork cloudwes2

put " "



process cloudwes1
    loop
	%if the cloud is higher than the 0 point then start the loop
	if ycloud1 > 0 then
	    loop
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%the cloud is going to move down 7 pixels at a time
		ycloud1 := ycloud1 - 7
		%draw the cloud, and picMerge command is to merge the picture to the background
		Pic.Draw (cloud, xcloud1, ycloud1, picMerge)
		delay (10)
		%exit when the cloud is 500 pixels below 0
		exit when ycloud1 <= -500
	    end loop
	end if
	%reset the cloud value to 900 so that the cloud repeats the process
	ycloud1 := 900
    end loop
end cloudwes1

fork cloudwes1
put " "

process cloudwes
    loop
	%if the cloud is higher than the 0 point then start the loop
	if ycloud > 0 then
	    loop
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%the cloud is going to move down 5 pixels at a time (the number is in a constant)
		ycloud := ycloud - movedowncloud
		%draw the cloud, and picMerge command is to merge the picture to the background without copying it, to keep the transparency
		Pic.Draw (cloud, xcloud, ycloud, picMerge)
		delay (10)
		%exit when the cloud is 100 pixels below 0
		exit when ycloud <= -100
	    end loop
	end if
	%reset the cloud value to 900 so that the cloud repeats the process
	ycloud := 900
    end loop
end cloudwes

fork cloudwes
put " "
%refreshes the page so that there is minimal flickering
View.Update

process test1
    loop
	%if the game has been over then exit the loop
	if gameover = true then
	    exit
	end if
	%get the command from the user`s keyboard
	getch (key)
	%set the bullet`s coordinates to the same as the airplane`s
	xbullet1 := x
	ybullet1 := y
	%if spacebar is pressed then release the bullet
	if key = " " then
	    loop
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%draw the green bullet which is 75 pixels to the left of airplane, and has a move command that moves the bullet up
		drawfilloval (xbullet1 + 75, ybullet1 + 45 + move1, 5, 5, green)
		%move the bullet up 10 pixels (used a constant)
		move1 := move1 + moveupbullet
		%exit the loop when the bullet is above 500 pixels
		exit when move1 >= 500
		delay (10)
	    end loop
	end if
	%check certain vertical and horizontal coordinates on plane 4 to see if they are green, and if so then the planeexit4 command should be true
	if whatdotcolor (xplane4 + 35, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 46) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 44) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 42) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 40) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 38) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 37, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 39, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 41, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 43, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 33, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 30, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 28, yplane4 + 48) = green then
	    planeexit4 := true
	end if
	%check certain vertical and horizontal coordinates on plane 3 to see if they are green, and if so then the planeexit3 command should be true
	if whatdotcolor (xplane3 + 35, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 46) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 44) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 42) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 40) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 38) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 37, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 39, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 41, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 43, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 33, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 30, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 28, yplane3 + 48) = green then
	    planeexit3 := true
	end if
	%check certain vertical and horizontal coordinates on plane 2 to see if they are green, and if so then the planeexit2 command should be true
	if whatdotcolor (xplane2 + 35, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 46) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 44) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 42) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 40) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 38) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 37, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 39, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 41, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 43, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 33, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 30, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 28, yplane2 + 48) = green then
	    planeexit2 := true
	end if
	%check certain vertical and horizontal coordinates on plane 1 to see if they are green, and if so then the planeexit1 command should be true
	if whatdotcolor (xplane1 + 35, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 46) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 44) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 42) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 40) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 38) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 37, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 39, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 41, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 43, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 33, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 30, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 28, xplane1 + 48) = green then
	    planeexit1 := true
	end if
	%these if statements checks if the bullet is within (66,96) of any of the airplanes` center and if so then the appropriate plane exit command is true
	%these if statements are in addition to the previous collision detect statements in order to minimize the chances of an error
	if xbullet > xplane4 and xbullet < xplane4 + 66 and ybullet + move > yplane4 and ybullet + move1 < yplane4 + 96 then
	    planeexit4 := true
	elsif xbullet > xplane3 and xbullet < xplane3 + 66 and ybullet + move > yplane3 and ybullet + move1 < yplane3 + 96 then
	    planeexit3 := true
	elsif xbullet > xplane2 and xbullet < xplane2 + 66 and ybullet + move > yplane2 and ybullet + move1 < yplane2 + 96 then
	    planeexit2 := true
	elsif xbullet > xplane1 and xbullet < xplane1 + 66 and ybullet + move > yplane1 and ybullet + move1 < yplane1 + 96 then
	    planeexit1 := true
	end if
	%reset the move value to 0 so that the next time a bullet is fired, it starts at the airplane level
	move1 := 0
    end loop
end test1

fork test1
put " "

process test
    loop
	%get the command from the user`s keyboard
	getch (key)
	%set the bullet`s coordinates to the same as the airplane`s
	xbullet := x
	ybullet := y
	%if spacebar is pressed then release the bullet
	if key = " " then
	    loop
		%if the game has been over then exit the loop
		if gameover = true then
		    exit
		end if
		%draw the green bullet which is 45 pixels to the left of airplane, and has a move command that moves the bullet up
		drawfilloval (xbullet, ybullet + 45 + move, 5, 5, green)
		%move the bullet up 10 pixels (used a constant)
		move := move + moveupbullet
		%exit the loop when the bullet is above 500 pixels
		exit when move >= 500
		delay (10)
	    end loop
	end if
	%check certain vertical and horizontal coordinates on plane 4 to see if they are green, and if so then the planeexit4 command should be true
	if whatdotcolor (xplane4 + 35, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 46) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 44) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 42) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 40) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 35, yplane4 + 38) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 37, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 39, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 41, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 43, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 33, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 30, yplane4 + 48) = green then
	    planeexit4 := true
	elsif whatdotcolor (xplane4 + 28, yplane4 + 48) = green then
	    planeexit4 := true
	end if
	%check certain vertical and horizontal coordinates on plane 3 to see if they are green, and if so then the planeexit3 command should be true
	if whatdotcolor (xplane3 + 35, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 46) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 44) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 42) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 40) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 35, yplane3 + 38) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 37, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 39, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 41, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 43, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 33, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 30, yplane3 + 48) = green then
	    planeexit3 := true
	elsif whatdotcolor (xplane3 + 28, yplane3 + 48) = green then
	    planeexit3 := true
	end if
	%check certain vertical and horizontal coordinates on plane 2 to see if they are green, and if so then the planeexit2 command should be true
	if whatdotcolor (xplane2 + 35, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 46) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 44) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 42) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 40) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 35, yplane2 + 38) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 37, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 39, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 41, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 43, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 33, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 30, yplane2 + 48) = green then
	    planeexit2 := true
	elsif whatdotcolor (xplane2 + 28, yplane2 + 48) = green then
	    planeexit2 := true
	end if
	%check certain vertical and horizontal coordinates on plane 1 to see if they are green, and if so then the planeexit1 command should be true
	if whatdotcolor (xplane1 + 35, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 46) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 44) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 42) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 40) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 35, xplane1 + 38) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 37, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 39, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 41, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 43, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 33, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 30, xplane1 + 48) = green then
	    planeexit1 := true
	elsif whatdotcolor (xplane1 + 28, xplane1 + 48) = green then
	    planeexit1 := true
	end if
	%these if statements checks if the bullet is within (66,96) of any of the airplanes` center and if so then the appropriate plane exit command is true
	%these if statements are in addition to the previous collision detect statements in order to minimize the chances of an error
	if xbullet > xplane4 and xbullet < xplane4 + 66 and ybullet + move > yplane4 and ybullet + move < yplane4 + 96 then
	    planeexit4 := true
	elsif xbullet > xplane3 and xbullet < xplane3 + 66 and ybullet + move > yplane3 and ybullet + move < yplane3 + 96 then
	    planeexit3 := true
	elsif xbullet > xplane2 and xbullet < xplane2 + 66 and ybullet + move > yplane2 and ybullet + move < yplane2 + 96 then
	    planeexit2 := true
	elsif xbullet > xplane1 and xbullet < xplane1 + 66 and ybullet + move > yplane1 and ybullet + move < yplane1 + 96 then
	    planeexit1 := true
	end if
	%reset the move value to 0 so that the next time a bullet is fired, it starts at the airplane level
	move := 0
    end loop
end test

fork test
loop
    %if the game has been over then exit the loop
    if gameover = true then
	exit
    end if
    %the parallelget value comes from the controlling joystick
    %if the parallelget value is 104 then move up two pixels
    if parallelget = 104 then
	y := y + 2
	%if the parallelget value is 168 then move right two pixels
    elsif parallelget = 168 then
	x := x + 2
	%if the parallelget value is 56 then move left two pixels
    elsif parallelget = 56 then
	x := x - 2
	%if the parallelget value is 8 then move down two pixels
    elsif parallelget = 8 then
	y := y - 2
	%if the parallelget value is 120 then move upleft
    elsif parallelget = 120 then
	y := y + 2
	x := x - 2
	%if the parallelget value is 232 then move upright
    elsif parallelget = 232 then
	y := y + 2
	x := x + 2
	%if the parallelget value is 24 then move downleft
    elsif parallelget = 24 then
	y := y - 2
	x := x - 2
	%if the parallelget value is 136 then move downright
    elsif parallelget = 136 then
	y := y - 2
	x := x + 2
    end if
    %10 millisecond delay before drawing
    delay (10)
    %draw image of background
    Pic.Draw (background_image, 0, 0, 0)
    %draw image of main shooting airplane that is to be controlled
    %the x and y values of the airplane are determined by the parallelget if statements
    Pic.Draw (airplane, x, y, picMerge)
    %if certain points of airplane on the left right top and center are detected to be black (which is the oval drawn ontop of the enemy airplanes) then the gameover is true
    if whatdotcolor (x + 47, y + 96) = black then
	gameover := true
    end if
    if whatdotcolor (x + 49, y + 96) = black then
	gameover := true
    end if
    if whatdotcolor (x + 48, y + 96) = black then
	gameover := true
    end if
    if whatdotcolor (x + 96, y + 48) = black then
	gameover := true
    end if
    if whatdotcolor (x, y + 48) = black then
	gameover := true
    end if
    if whatdotcolor (x + 48, y) = black then
	gameover := true
    end if
    %if the game is over then
    if gameover = true then
	%erase everything on the screen
	cls
	%draw the empty background first
	Pic.Draw (background_image, 0, 0, 0)
	%if the game has not been won then
	if win = false then
	    %clear screen once again
	    cls
	    %draw gameover screen which shows the loss of the game
	    Pic.Draw (over, 0, 0, picMerge)
	end if
    end if
end loop

%-----------------------------------------------------------------------------------END OF GAME CODE-----------------------------------------------------------------------------------
