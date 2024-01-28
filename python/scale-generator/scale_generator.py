TWO_SCALE_CHROMATIC_FLATS = ["A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab"] * 2
TWO_SCALE_CHROMATIC_SHARPS = ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"] * 2

class Scale:
    def __init__(self, tonic):
        self.tonic = tonic
        self.capital_tonic = tonic.capitalize()

    def chromatic(self):
        return self.scale(self.tonic_index())

    def scale(self, start):
        SHARP_TONICS = ["C", "G", "D", "A", "E", "B", "F#", "a", "e", "b", "f#", "c#", "g#", "d#"]
        if (self.tonic in SHARP_TONICS):
            return TWO_SCALE_CHROMATIC_SHARPS[start:start+12]
        else:
            return TWO_SCALE_CHROMATIC_FLATS[start:start+12]

    def tonic_index(self):
        if self.capital_tonic in TWO_SCALE_CHROMATIC_SHARPS:
            return TWO_SCALE_CHROMATIC_SHARPS.index(self.capital_tonic)
        else:
            return TWO_SCALE_CHROMATIC_FLATS.index(self.capital_tonic)

    def interval(self, intervals):
        INTERVAL_OFFSETS = {"m": 1, "M": 2, "A": 3}
        scale = self.chromatic() + [self.capital_tonic]
        interval_notes = [self.capital_tonic]
        current_note = 0
        for interval in intervals:
            current_note += INTERVAL_OFFSETS[interval]
            interval_notes.append(scale[current_note])
        
        return interval_notes
