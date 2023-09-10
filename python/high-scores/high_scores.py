class HighScores:
    def __init__(self, scores):
        self.scores = scores

    def latest(self):
        return self.scores[-1]

    def personal_best(self):
        return self.top_n(1)[0]

    def personal_top_three(self):
        return self.top_n(3)

    def top_n(self, n):
        return sorted(self.scores, reverse=True)[0:n]
