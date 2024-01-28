from operator import itemgetter

result_offsets = { "win": [1, 0, 0, 3], "loss": [0, 0, 1, 0], "draw": [0, 1, 0, 1] }

class Result:
    def __init__(self, name):
        self.name = name
        self.matches_played = self.wins = self.losses = self.draws = self.points = 0

    def record_result(self, result):
        self.matches_played += 1
        self.wins += result_offsets[result][0]
        self.draws += result_offsets[result][1]
        self.losses += result_offsets[result][2]
        self.points += result_offsets[result][3]

        return self
    
    def __gt__(self, other):
        if (self.points > other.points):
            return True
        
        return self.name < other.name if self.points == other.points else False

    def __str__(self):
        return f"{self.name:30} |  {self.matches_played} |  {self.wins} |  {self.draws} |  {self.losses } | {self.points:>2}"

def tally(rows):
    result_opposites = {"win": "loss", "loss": "win", "draw": "draw"}
    team_results = {}
    for result_row in rows:
        team1, team2, team1_result = result_row.split(";")
        team1_tally = team_results.get(team1, Result(team1))
        team2_tally = team_results.get(team2, Result(team2))
        team_results[team1] = team1_tally.record_result(team1_result)
        team_results[team2] = team2_tally.record_result(result_opposites[team1_result])

    tally_str = [f"{'Team':30} | MP |  W |  D |  L |  P"]
    for team in sorted(team_results.values(), reverse=True):
        tally_str.append(str(team))

    return tally_str
