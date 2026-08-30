module Tournament
    class TeamResults
        def initialize(team)
            @team = team
            @played = @wins = @draws = @losses = @points = 0
        end

        def record_win()
            record_game()
            @wins += 1
            @points += 3

            self
        end

        def record_loss()
            record_game()
            @losses += 1

            self
        end

        def record_draw()
            record_game()
            @draws += 1
            @points += 1

            self
        end
        
        def to_s()
            "#{team.ljust(31)}| #{played.to_s.rjust(2)} | #{wins.to_s.rjust(2)} | #{draws.to_s.rjust(2)} | #{losses.to_s.rjust(2)} | #{points.to_s.rjust(2)}"
        end

        attr_reader :wins, :losses, :points, :draws, :played, :team

        private

        def record_game()
            @played += 1
        end

    end

    def self.tally(input)

        teams = {}
        input.split("\n").each do 
            | line |
            team1, team2, result = line.split(";")
            team1_results = teams.fetch(team1, TeamResults.new(team1))
            team2_results = teams.fetch(team2, TeamResults.new(team2))
            
            case result
            when "win"
                teams[team1] = team1_results.record_win
                teams[team2] = team2_results.record_loss
            when "loss"
                teams[team1] = team1_results.record_loss
                teams[team2] = team2_results.record_win
            when "draw"
                teams[team1] = team1_results.record_draw
                teams[team2] = team2_results.record_draw
            end
        end

        table_order = teams.sort_by { | _team,  result | [-result.points, result.team] }
        records = table_order.map { | _team, results | "#{results.to_s}\n" }.join()
        
        "Team                           | MP |  W |  D |  L |  P\n" + records
    end
end