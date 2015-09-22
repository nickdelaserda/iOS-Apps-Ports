-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Simple game app. User taps screen and the background changes color as well as
-- a "meow" is played. After user reaches 10, money rains and they are congratulated.
--
-- @author Nick DeLaSerda
-- @version 20150922
--
-----------------------------------------------------------------------------------------



--starting ads ---------- Android variant -------------- 
--local ads = require("ads")
--local appID = "ca-app-pub-9392451087910821/2510929197"
--------------------------------------------------------

--start physics
local physics = require("physics")
physics.start()



--display start menu

local gameTitle = display.newText("Cat Attack", 160, 35, arial, 60)
gameTitle:setTextColor(0,0,250)

local startBtn = display.newText("Play", 160, 200, arial, 40)
startBtn:setTextColor(0,250,0)

local quitBtn = display.newText("Quit", 160, 350, arial, 40)
quitBtn:setTextColor(250,0,0)


	
	
		 
		function startGame()
		--displaying initial images
		local black = display.newImage( "background/black.png")
		black.x= 0; black.y = 195

		local cat = display.newImage("resources/pictures/cat.png")
		cat.x = 160 cat.y = 250

		--loading multiple pics into table called pics
		local pics = { "background/blue.png", "background/green.png", "background/orange.png", "background/purple.png", "background/red.png", "background/yellow.png"}

		--load sound
		local catEffect = audio.loadSound("resources/sounds/cat.wav")

		--load money rain
		local rain = ("resources/pictures/money.png")
		 
		win = 0
		score = 0

		--local prevFrameTime, currentFrameTime --both nil
		--local deltaFrameTime = 0

		--local txt_counter = display.newText( totalTime, 0, 0, native.systemFont, 50 )
		--txt_counter.x = 150
		--txt_counter.y = 288
		--txt_counter:setTextColor( 255, 255, 255 )
		--group:insert( txt_counter )
				
			

			function screenTap()

		    
				--if user won, go back to starting picture and remove previous rain
				if win == 1 then
					display.newImage("background/black.png")
					local cat = display.newImage("resources/pictures/cat.png")
					cat.x = 160 cat.y = 250
					win = 0
						for count=1, 100, 1 do
							moneyRain:removeSelf()
						end
					return
				end
				if notFirst ==1 then 
					prevNum = num
				end

				--generates random number
				local num = math.random(1, 6)
				if notFirst == 1 then
					if num == prevNum then
						repeat
							num = math.random(1,6)
							until num ~= prevNum
					end
				end

				--picks a random number and displays corresponding picture
				local chosenPic = pics[num]
				local obj = display.newImage(chosenPic)
				local cat = display.newImage("resources/pictures/cat.png")
				cat.x = 160 cat.y = 250

				--make it rain yo
				for fCounter=1, 2, 1 do 
						for counter=1, 500, 100 do
							randomNumber = math.random(-200, -50)
							moneyRain = display.newImage("resources/pictures/money.png")
							moneyRain.x = counter
							moneyRain.y = randomNumber
							moneyRain:scale(.5,.5)
							physics.addBody(moneyRain, {density = 3.0, friction=0, bounce=0} )
						end
					end

				--increase score
				score = score + 1
				local scoreDisplay = display.newText(score, 160, 35, arial, 60 )
				audio.play(catEffect)

				--if user reaches ten, give congrats
				if score ==  10 then
					display.newImage("background/white.png")
					local money = display.newImage("resources/pictures/money.jpg")
					money:scale(.8,.8) 
					money.x = 160 money.y = 250
					local winner = display.newText("Congrats! You Won!", 150, 50,arial,30)
					winner:setFillColor(0,0,0)
					for fCounter=1, 10, 1 do 
						for counter=1, 500, 50 do
							randomNumber = math.random(-200, -50)
							moneyRain = display.newImage("resources/pictures/money.png")
							moneyRain.x = counter
							moneyRain.y = randomNumber
							moneyRain:scale(.5,.5)
							physics.addBody(moneyRain, {density = 3.0, friction=0, bounce=0} )
						end
					end

					local endBtn = display.newText("End Game", 290, 0, arial, 12)
					endBtn:setTextColor(0,0,0)

					function endGame()
						os.exit()
					end


					--reset variables
					score = 0
					cat:removeSelf()
					cat = nil
					win = 1
					endBtn:addEventListener("tap",endGame)
		    	end


				prevNum = nil
				notFirst = 1
			end
			cat:addEventListener( "tap", screenTap)
		end

		function quitGame()
			os.exit()
		end
	

startBtn:addEventListener( "tap", startGame)
quitBtn:addEventListener( "tap", quitGame)
