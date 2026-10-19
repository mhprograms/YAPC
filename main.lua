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
		y = 250,
	}
	player2 = {
		x = 760,
		y = 250,
	}
	ball = {
		x = window.width / 2,
		y = window.height / 2,
		radius = 10,
		velx = 250 * math.cos(math.rad(0)),
		vely = 250 * math.sin(math.rad(0)),
	}
	love.window.setMode(window.width, window.height)		
end
local pong = require("funcs")
function love.update(dt)
	pong.detectCollisionBetweenBallandPlayer1()
	pong.detectCollisionBetweenBallandPlayer2()
	pong.moveThePaddlesAndKeepThemOnScreen(dt)
	pong.moveTheBall(dt)
	pong.bounceBallWhentheTopOrBottomWallisHit()
	pong.dealWithTheBallWhenItHitsTheLeftOrRightWall()	
end
function love.draw()
	for i = 0, 600, 30 do
		love.graphics.rectangle("fill", 392.5, i, 15, 15)
	end
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", player1.x, player1.y, paddle.width, paddle.height)
	love.graphics.rectangle("fill", player2.x, player2.y, paddle.width, paddle.height)
	love.graphics.circle("fill", ball.x, ball.y, ball.radius)
	love.graphics.setColor(0.22, 1.0, 0.08)
end
