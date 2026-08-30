module Tournament
    class TeamResults
        def initialize(team)
            @team = team
            @played = 0
            @wins = 0
            @draws = 0
            @losses = 0
            @points = 0
        end

        def record_win()
            @played += 1
            @wins += 1
            @points += 3

            self
        end

        def record_loss()
            @played += 1
            @losses += 1

            self
        end

        def record_draw()
            @played += 1
            @draws += 1
            @points += 1

            self
        end
        
        def to_s()
            "| #{played.to_s.rjust(2)} | #{wins.to_s.rjust(2)} | #{draws.to_s.rjust(2)} | #{losses.to_s.rjust(2)} | #{points.to_s.rjust(2)}"
        end

        attr_reader :wins, :losses, :points, :draws, :played, :team
    end

    def self.tally(input)

        teams = {}
        input.split("\n").each do 
            | line |
            team1, team2, result = line.split(";")
            
            case result
            when "win"
                team1_results = teams.fetch(team1, TeamResults.new(team1))
                teams[team1] = team1_results.record_win
                team2_results = teams.fetch(team2, TeamResults.new(team2))
                teams[team2] = team2_results.record_loss
            when "loss"
                team1_results = teams.fetch(team1, TeamResults.new(team1))
                teams[team1] = team1_results.record_loss
                team2_results = teams.fetch(team2, TeamResults.new(team2))
                teams[team2] = team2_results.record_win
            when "draw"
                team1_results = teams.fetch(team1, TeamResults.new(team1))
                teams[team1] = team1_results.record_draw
                team2_results = teams.fetch(team2, TeamResults.new(team2))
                teams[team2] = team2_results.record_draw
            end
        end

        table_order = teams.sort_by { | _team,  result | [-result.points, result.team] }
        records = table_order.map { | team, results | "#{team.ljust(30)} #{results.to_s}\n" }.join()
        
        "Team                           | MP |  W |  D |  L |  P\n" + records
    end
end