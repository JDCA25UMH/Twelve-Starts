
local Button = require "button"

local imagen

math.randomseed(os.time()) 

local game = {
    state = {
        menu = true, 
        running = false,
    }
}


local buttons= {
    colors= {
        red= 0.6, 
        blue=0.6,
        green=0.6
    },
    
menu_state = {},
restart = {}
    
}

local restart_space= 60 
function love.load(  )
    imagen = love.graphics.newImage("fire.png")
	love.graphics.setBackgroundColor(0,0,0)


function generatePositions(count)
    posiciones = {}
    for i = 1, count do
        table.insert(posiciones, {
            x = math.random(0, love.graphics.getWidth() - imagen:getWidth()),
            y = math.random(0, love.graphics.getHeight() - imagen:getHeight() - restart_space)
        })
    end
end

-- Usage
generatePositions(12)

local function startNewGame()
   game.state["menu"] = false
    game.state["running"] = true
end

local function restart()
while #posiciones>0 do
table.remove(posiciones, i)
end
generatePositions(12)
end
buttons.menu_state.play_game = Button(startNewGame,{r = buttons.colors["red"], g = buttons.colors["green"], b = buttons.colors["blue"]},
 {r = 0, g = 0, b = 0}, 120, 40)
buttons.menu_state.settings= Button(nil, {r = buttons.colors["red"], g = buttons.colors["green"], b = buttons.colors["blue"]}, 
    {r = 0, g = 0, b = 0}, 120, 40 )


buttons.restart.restart_01 = Button(restart , {r = buttons.colors["red"], g = buttons.colors["green"], b = buttons.colors["blue"]}, 
    {r = 0, g = 0, b = 0}, 120, 40)

buttons.restart.exit = Button(love.event.quit, {r = buttons.colors["red"], g = buttons.colors["green"], b = buttons.colors["blue"]}, 
    {r = 0, g = 0, b = 0}, 120, 40)

end
function love.update(dt)

function love.mousepressed(x, y, button, istouch, presses)
    if not game.state["running"] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menu_state) do -- check if one of the buttons were pressed
                    buttons.menu_state[index]:checkPressed(x, y)
              
                end
            end
         end
      end
  elseif game.state["running"]then 

for index in pairs(buttons.restart)do
buttons.restart[index]:checkPressed(x,y)

   end
end


end

function love.draw()
if game.state["running"]then

 for i, posicion in ipairs(posiciones) do
        love.graphics.draw(imagen, posicion.x, posicion.y, 0 , 0.5, 0.5)
    end

buttons.restart.restart_01:draw("Restart", (love.graphics.getWidth()/4),
    love.graphics.getHeight() - restart_space,
    17,10)

buttons.restart.exit:draw("Exit", love.graphics.getWidth() - love.graphics.getWidth()/3,
    love.graphics.getHeight() - restart_space,
    17,10)

elseif game.state["menu"]then 
local fondo= love.graphics.newFont(16)
buttons.menu_state.play_game:draw("Play Game", 10, 20, 17, 10)
love.graphics.setFont(fondo)
 buttons.menu_state.settings:draw("Settings", 10, 70, 17, 10)


end
end
end
