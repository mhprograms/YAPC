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
		love.audio.play(sound1)
		local paddleMiddlexPosition = player1.x + (paddle.width / 2)
		if closestPointToBallOnPlayer1xPosition < paddleMiddlexPosition then
			local normalisedHitPosition = ((player1.y + (paddle.height / 2)) - ball.y) / (paddle.height / 2)
			local newBallAngle = 180 + (normalisedHitPosition * 45)
			ball.velx = paddle.speed * math.cos(math.rad(newBallAngle))
			ball.vely = paddle.speed * math.sin(math.rad(newBallAngle))
			ball.x = player1.x - ball.radius		
		else
			local normalisedHitPosition = ((player1.y + (paddle.height / 2)) - ball.y) / (paddle.height / 2)
			local newBallAngle = 0 - (normalisedHitPosition * 45)
			ball.velx = paddle.speed * math.cos(math.rad(newBallAngle))
			ball.vely = paddle.speed * math.sin(math.rad(newBallAngle))
			ball.x = player1.x + paddle.width + ball.radius
		end	
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
		love.audio.play(sound1)
		local paddleMiddlexPosition = player2.x + (paddle.width / 2)
		if closestPointToBallOnPlayer2xPosition > paddleMiddlexPosition then
			local normalisedHitPosition = ((player2.y + (paddle.height / 2)) - ball.y) / (paddle.height / 2)
			local newBallAngle = 0 - (normalisedHitPosition * 45)
			ball.velx = paddle.speed * math.cos(math.rad(newBallAngle))
			ball.vely = paddle.speed * math.sin(math.rad(newBallAngle))
			ball.x = player2.x + paddle.width + ball.radius	
		else
			local normalisedHitPosition = ((player2.y + (paddle.height / 2)) - ball.y) / (paddle.height / 2)
			local newBallAngle = 180 + (normalisedHitPosition * 45)
			ball.velx = paddle.speed * math.cos(math.rad(newBallAngle))
			ball.vely = paddle.speed * math.sin(math.rad(newBallAngle))
			ball.x = player2.x - ball.radius
		end
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
		love.audio.play(sound2)
		ball.y = 0 + ball.radius
		ball.vely = -ball.vely
	elseif ball.y + ball.radius > window.height then
		love.audio.play(sound2)
		ball.y = window.height - ball.radius
		ball.vely = -ball.vely
	end
end
function pong.dealWithTheBallWhenItHitsTheLeftOrRightWall()
	local whichPlayerGetsTheBall
	if ball.x - ball.radius < 0 then
		love.audio.play(sound3)
		player2.score = player2.score + 1
		whichPlayerGetsTheBall = 1
	elseif ball.x + ball.radius > window.width then
		love.audio.play(sound3)
		player1.score = player1.score + 1
		whichPlayerGetsTheBall = 2
	end
	if whichPlayerGetsTheBall == 1 then
		local newBallAngle = love.math.random(135, 225)
		ball.x, ball.y = window.width / 2, window.height / 2
		ball.velx = 250 * math.cos(math.rad(newBallAngle))
		ball.vely = 250 * math.sin(math.rad(newBallAngle))
	elseif whichPlayerGetsTheBall == 2 then
		local newBallAngle = love.math.random(-45, 45)
		ball.x, ball.y = window.width / 2, window.height / 2
		ball.velx = 250 * math.cos(math.rad(newBallAngle))
		ball.vely = 250 * math.sin(math.rad(newBallAngle))			
	end
end
function pong.checkIfGameWon()
	if player1.score >= 11 or player2.score >= 11 then
		gameState = "won"
	end 
end
function pong.detectCrash()
	if love.keyboard.isDown("lctrl") and love.keyboard.isDown("lalt") and love.keyboard.isDown("lshift") and love.keyboard.isDown("c") then
		neverGonnaGiveYouUpNeverGonnaLetYouDownNeverGonnaRunAroundAndDesertYouNeverGonnaMakeYouCryNeverGonnaSayGoodbyeNeverGonnaTellALieAndHurtYou = neverGonnaGiveYouUpNeverGonnaLetYouDownNeverGonnaRunAroundAndDesertYouNeverGonnaMakeYouCryNeverGonnaSayGoodbyeNeverGonnaTellALieAndHurtYou + 1
	end
end
function pong.listenToKeyboard()
	if love.keyboard.isDown("p") then
		gameState = "playing"
	end
	if love.keyboard.isDown("c") then
		gameState = "controlmenu"
	end
end
function pong.detectIfMenu()
	if love.keyboard.isDown("escape") then
		gameState = "menu"
		reset()
	end
end
function reset()
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
end
return pong
