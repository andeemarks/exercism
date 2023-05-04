CompassPoint = {left = "", right = ""}

function CompassPoint:new (left, right)
    compass = {}
    setmetatable(compass, self)
    self.__index = self
    self.left = left
    self.right = right

    return compass
end

local compass = {
    north = CompassPoint:new("west", "east"),
    south = CompassPoint:new("east", "west"),
    east = CompassPoint:new("north", "south"),
    west = CompassPoint:new("south", "north")
}

Robot = {x = 0, y = 0, heading = ""}

function Robot:new (x, y, heading)
    robot = {}
    setmetatable(robot, self)
    self.__index = self
    self.x = x
    self.y = y
    self.heading = heading

    return robot

end

function Robot:move(commands) 
    commands:gsub(".", function(command)
        if (command == 'A') then
            if (self.heading == "north") then
                self.y = self.y + 1
            elseif (self.heading == "east") then
                self.x = self.x + 1
            elseif (self.heading == "south") then
                self.y = self.y - 1
            else 
                self.x = self.x - 1
            end
        elseif (command == 'R') then
            self.heading = compass[self.heading].right
            -- if (self.heading == "north") then
            --     self.heading = "east"
            -- elseif (self.heading == "east") then
            --     self.heading = "south"
            -- elseif (self.heading == "south") then
            --     self.heading = "west"
            -- else 
            --     self.heading = "north"
            -- end
        elseif (command == 'L') then
            if (self.heading == "north") then
                self.heading = "west"
            elseif (self.heading == "east") then
                self.heading = "north"
            elseif (self.heading == "south") then
                self.heading = "east"
            else 
                self.heading = "south"
            end
        else
            error()
        end

    end)
end

return function(config)
    return Robot:new(config.x, config.y, config.heading)
end
