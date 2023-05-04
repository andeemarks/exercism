let leap_year year = 
    if mod_float (float_of_int year) 4.0 == 0.0 then begin
        if mod_float (float_of_int year) 100.0 == 0.0 then begin 
            if mod_float (float_of_int year) 400.0 == 0.0 then 
                true 
            else
                false
        end
    end else begin
        false
    end

