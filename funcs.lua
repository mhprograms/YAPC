local pong = {}
function pong.detectCollisionBetweenBallandPlayer1()
	local closestPointToBallOnPlayer1xPosition, closestPointToBallOnPlayer1yPosition = ball.x, ball.y
	if ball.x < player1.x then
		closestPointToBallOnPlayer1xPosition = player1.x
	elseif ball.x > player1.x + paddle.width then
		closestPointToBallOnPlayer1xPosition = player1.x + paddle.width
	end
	if ball.y < player1.y then
		closestPointToBallOnPlayer1yPosition = player1.y
	elseif ball.y > player1.y + paddle.height then
		closestPointToBallOnPlayer1yPosition = player1.y + paddle.height
	end
	if math.sqrt((closestPointToBallOnPlayer1xPosition - ball.x)^2 + (closestPointToBallOnPlayer1yPosition - ball.y)^2) <= ball.radius then
		local normalisedHitPosition = ((player1.y + (paddle.height / 2)) - ball.y) / (paddle.height / 2)
		local newBallAngle = 0 - (normalisedHitPosition * 45)
		ball.velx = paddle.speed * math.cos(math.rad(newBallAngle))
		ball.vely = paddle.speed * math.sin(math.rad(newBallAngle))
		ball.x = player1.x + paddle.width + ball.radius
	end		
end
function pong.detectCollisionBetweenBallandPlayer2()
	local closestPointToBallOnPlayer2xPosition, closestPointToBallOnPlayer2yPosition = ball.x, ball.y
	if ball.x < player2.x then
		closestPointToBallOnPlayer2xPosition = player2.x
	elseif ball.x > player2.x + paddle.width then
		closestPointToBallOnPlayer2xPosition = player2.x + paddle.width
	end
	if ball.y < player2.y then
		closestPointToBallOnPlayer2yPosition = player2.y
	elseif ball.y > player2.y + paddle.height then
		closestPointToBallOnPlayer2yPosition = player2.y + paddle.height
	end
	if math.sqrt((closestPointToBallOnPlayer2xPosition - ball.x)^2 + (closestPointToBallOnPlayer2yPosition - ball.y)^2) <= ball.radius then
		local normalisedHitPosition = ((player2.y + (paddle.height / 2)) - ball.y) / (paddle.height / 2)
		local newBallAngle = 180 + (normalisedHitPosition * 45)
		ball.velx = paddle.speed * math.cos(math.rad(newBallAngle))
		ball.vely = paddle.speed * math.sin(math.rad(newBallAngle))
		ball.x = player2.x - ball.radius
	end
end
function pong.moveThePaddlesAndKeepThemOnScreen(deltaTime)
	if love.keyboard.isDown("w") then
		player1.y = player1.y - paddle.speed * deltaTime
	end
	if love.keyboard.isDown("s") then
		player1.y = player1.y + paddle.speed * deltaTime
	end
	if player1.y > 500 then
		player1.y = 500
	elseif player1.y < 0 then
		player1.y = 0
	end
	if love.keyboard.isDown("up") then
		player2.y = player2.y - paddle.speed * deltaTime
	end
	if love.keyboard.isDown("down") then
		player2.y = player2.y + paddle.speed * deltaTime
	end
	if player2.y > 500 then
		player2.y = 500
	elseif player2.y < 0 then
		player2.y = 0
	end
end
function pong.moveTheBall(deltaTime)
	ball.x = ball.x + ball.velx * deltaTime
	ball.y = ball.y + ball.vely * deltaTime		
end
function pong.bounceBallWhentheTopOrBottomWallisHit()
	if ball.y - ball.radius < 0 then
		ball.y = 0 + ball.radius
		ball.vely = -ball.vely
	elseif ball.y + ball.radius > window.height then
		ball.y = window.height - ball.radius
		ball.vely = -ball.vely
	end
end
function pong.dealWithTheBallWhenItHitsTheLeftOrRightWall()
	local ballOffScreen, whichPlayerGetsTheBall
	if ball.x - ball.radius < 0 then
		ballOffScreen = true
		whichPlayerGetsTheBall = 2
	elseif ball.x + ball.radius > window.width then
		ballOffScreen = true
		whichPlayerGetsTheBall = 1
	end
	if whichPlayerGetsTheBall == 1 then
		local newBallAngle = math.random(135, 225)
		ball.x, ball.y = window.width / 2, window.height / 2
		ball.velx = 250 * math.cos(math.rad(newBallAngle))
		ball.vely = 250 * math.sin(math.rad(newBallAngle))
	elseif whichPlayerGetsTheBall == 2 then
		local newBallAngle = math.random(-45, 45)
		ball.x, ball.y = window.width / 2, window.height / 2
		ball.velx = 250 * math.cos(math.rad(newBallAngle))
		ball.vely = 250 * math.sin(math.rad(newBallAngle))			
	end
end
return pong
