function love.load()
	window = {
		width = 800,
		height = 600,
	}
	paddle = {
		width = 20,
		height = 100,
		speed = 500,		
	}
	player1 = {
		x = 20,
		y = 240,
		score = 0,
	}
	player2 = {
		x = 760,
		y = 240,
		score = 0,
	}
	ball = {
		x = window.width / 2,
		y = window.height / 2,
		radius = 10,
		velx = 250 * math.cos(math.rad(0)),
		vely = 250 * math.sin(math.rad(0)),
	}
	button = {
		x = 225,
		y1 = 250,
		y2 = 340,
		width = 350,
		height = 60,
	}
	love.window.setMode(window.width, window.height)
	gameState = "menu"
	soundState = "on"
	love.graphics.setFont(love.graphics.newFont("assets/PressStart2P-Regular.ttf"))
	scoreyPosition = 50
	wyPosition = 100
	iyPosition = 300
	nyPosition = 500
	pong = require("funcs")
	sound1 = love.audio.newSource("assets/paddlebounce.wav", "static")
	sound2 = love.audio.newSource("assets/wallbounce.wav", "static")
	sound3 = love.audio.newSource("assets/pointscore.wav", "static")
end
function love.update(dt)
	pong.detectCrash()
	pong.detectIfMenu()
	if gameState == "2player" or gameState == "cpu" then
		pong.detectCollisionBetweenBallandPlayer1()
		pong.detectCollisionBetweenBallandPlayer2()
		pong.moveThePaddles(dt)
		pong.moveTheBall(dt)
		pong.bounceBallWhentheTopOrBottomWallisHit()
		pong.dealWithTheBallWhenItHitsTheLeftOrRightWall()
		pong.checkIfGameWon()
	end
end
function love.keypressed(key)
	pong.listenToKeyboard(key)
end
function love.draw()
	if gameState == "2player" or gameState == "cpu" or gameState == "won" then
		love.graphics.setColor(0.22, 1.0, 0.08)
		for i = 0, 600, 30 do
			love.graphics.rectangle("fill", 392.5, i, 15, 15)
		end
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("fill", player1.x, player1.y, paddle.width, paddle.height)
		love.graphics.rectangle("fill", player2.x, player2.y, paddle.width, paddle.height)
		love.graphics.circle("fill", ball.x, ball.y, ball.radius)
		love.graphics.setColor(0.22, 1.0, 0.08)
		love.graphics.printf(player1.score, 0, scoreyPosition, 400, "center")
		love.graphics.printf(player2.score, 400, scoreyPosition, 400, "center")
		love.graphics.setColor(1, 1, 1)
	end
	if gameState == "won" then
		if player1.score == 11 then
			love.graphics.printf("W", 0, wyPosition, 400, "center")
			love.graphics.printf("I", 0, iyPosition, 400, "center")
			love.graphics.printf("N", 0, nyPosition, 400, "center")
		elseif player2.score == 11 then
			love.graphics.printf("W", 400, wyPosition, 400, "center")
			love.graphics.printf("I", 400, iyPosition, 400, "center")
			love.graphics.printf("N", 400, nyPosition, 400, "center")
		end
	end
	if gameState == "menu" then
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("line", button.x, button.y1, button.width, button.height)
		love.graphics.rectangle("line", button.x, button.y2, button.width, button.height)
		love.graphics.printf("PLAY(p)", button.x, button.y1 + button.height / 2 - 6, button.width, "center")
		love.graphics.printf("CONTROLS(c)", button.x, button.y2 + button.height / 2 - 6, button.width, "center")
	end
	if gameState == "controlMenu" then
		love.graphics.print("W/S to move the left paddle or to play when you're playing with the CPU.", 5, 5)
		love.graphics.print("Up/Down arrow to move the right paddle.", 5, 22)
		love.graphics.print("ESCAPE to go back to the menu.", 5, 39)
		love.graphics.print("D to toggle sound.", 5, 56)
	end
	if gameState == "optionsMenu" then
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("line", button.x, button.y1, button.width, button.height)
		love.graphics.rectangle("line", button.x, button.y2, button.width, button.height)
		love.graphics.printf("2 PLAYER(p)", button.x, button.y1 + button.height / 2 - 6, button.width, "center")
		love.graphics.printf("CPU(c)", button.x, button.y2 + button.height / 2 - 6, button.width, "center")	
	end
end