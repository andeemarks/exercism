class ResistorColorTrio
    def initialize(resistors)
        resistor1, resistor2, resistor3 = resistors

        magnitude = resistor_value(resistor3)
        @ohms = (resistor_value(resistor1) * 10 + resistor_value(resistor2)) * (10 ** magnitude)
    end

    def label()
        if @ohms % 1000 == 0
            @units = "kiloohms"
            @ohms /= 1000
        else
            @units = "ohms"
        end
        "Resistor value: #{@ohms} #{@units}"
    end
    
    private
    RESISTOR_VALUES = {"black" => 0, "brown" => 1, "red" => 2,"orange" => 3, "yellow" => 4, "green" => 5,"blue" => 6, "violet" => 7, "grey" => 8,"white" => 9}.freeze

    def resistor_value(resistor)
        RESISTOR_VALUES[resistor]
    end

end