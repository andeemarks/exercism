class ResistorColorTrio
    def initialize(resistors)
        resistor1, resistor2, resistor3 = resistors

        magnitude = resistor_value(resistor3)
        @ohms = (resistor_value(resistor1) * 10 + resistor_value(resistor2)) * (10 ** magnitude)
        if @ohms % 1000 == 0
            @units = "kiloohms"
            @ohms /= 1000
        else
            @units = "ohms"
        end
    end

    def resistor_value(resistor)
        case resistor
        when "black" then 0
        when "brown" then 1
        when "red" then 2
        when "orange" then 3
        when "yellow" then 4
        when "green" then 5
        when "blue" then 6
        when "violet" then 7
        when "grey" then 8
        when "white" then 9
        end
    end

    def label()
        "Resistor value: #{@ohms} #{@units}"
    end
end