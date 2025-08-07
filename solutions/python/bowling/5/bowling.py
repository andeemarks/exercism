from functools import reduce
from dataclasses import dataclass

STRIKE = 10
LAST_FRAME = 10

@dataclass
class Frame:
    first_pin: int = -1
    first_pin_number: int = -1
    second_pin: int = -1
    bonus_pin: int = 0

    def __init__(self, first_pin: int, first_pin_number: int, second_pin: int = -1, bonus_pin: int = 0):
        if first_pin + second_pin > 10:
            raise Exception("nup")
        
        self.first_pin = first_pin
        self.first_pin_number = first_pin_number
        self.second_pin = second_pin
        self.bonus_pin = bonus_pin

    def total(self) -> int:
        if (self.second_pin == -1):
            return self.first_pin + self.bonus_pin
        else:
            return self.first_pin + self.second_pin + self.bonus_pin
    
    def is_normal(self) -> bool:
        return not(self.is_spare() or self.is_strike())
    
    def is_strike(self) -> bool:
        return self.first_pin == STRIKE
    
    def is_full(self) -> bool:
        return self.first_pin >= 0 and self.second_pin >= 0

    def is_spare(self) -> bool:
        return self.first_pin + self.second_pin == 10 and not self.is_strike()
    
    def add_bonus(self, bonus):
        return Frame(self.first_pin, self.first_pin_number, self.second_pin, self.bonus_pin + bonus)

    def __repr__(self):
        if self.is_strike():
            return f"X ({self.bonus_pin})\n"
        elif self.is_spare():
            return f"{self.first_pin} -> / ({self.bonus_pin})\n"
        else:
            return f"{self.first_pin} -> {self.second_pin} ({self.bonus_pin})\n"
    
class BowlingGame:
    def __init__(self):
        self.pins = []

    def roll(self, pins):
        if pins not in range(0, 11):
            raise Exception("rolls_cannot_score_negative_points & a_roll_cannot_score_more_than_10_points")
    
        self.pins.append(pins)

        self._check_if_rollable()

    def _check_if_rollable(self):
        temp_frames = self.create_frames(self.pins)
        if len(temp_frames) > 10:
            last_frame = temp_frames[9]
            current_frame = temp_frames[10]
            if last_frame.is_normal():
                raise Exception("cannot_roll_if_game_already_has_ten_frames")
            if last_frame.is_spare() and current_frame.is_full():
                raise Exception("cannot_roll_after_bonus_roll_for_spare")
            if last_frame.is_strike() and not current_frame.is_strike() and len(temp_frames) > 11:
                raise Exception("cannot_roll_after_bonus_rolls_for_strike")

    def score(self):
        frames = self.create_frames(self.pins)
        self._validate_frame_length(frames)
        frames = self.apply_spare_bonus(frames)
        frames = self.apply_strike_bonus(frames)

        scores = map(lambda frame: frame.total(), frames)

        return sum(scores)

    def _validate_frame_length(self, frames):
        if (frames[9].is_strike() and len(frames) == 10):
            raise Exception("bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated")

        if (frames[9].is_spare() and len(frames) == 10):
            raise Exception("bonus_roll_for_a_spare_in_the_last_frame_must_be_rolled_before_score_can_be_calculated")

        if (frames[9].is_strike() and frames[10].is_strike() and len(frames) == 11):
            raise Exception("both_bonus_rolls_for_a_strike_in_the_last_frame_must_be_rolled_before_score_can_be_calculated")

    def apply_spare_bonus(self, frames: list[Frame]) -> list[Frame]:
        for i in range(0, len(frames)):
            if frames[i].is_spare() and i < LAST_FRAME - 1:
                frames[i] = frames[i].add_bonus(frames[i + 1].first_pin)

        return frames

    def apply_strike_bonus(self, frames: list[Frame]) -> list[Frame]:
        for i in range(0, len(frames)):
            if frames[i].is_strike() and i < LAST_FRAME - 1:
                pin_location = frames[i].first_pin_number
                next_2_pins = self.pins[pin_location + 1] + self.pins[pin_location + 2]
                frames[i] = frames[i].add_bonus(next_2_pins)

        return frames

    def create_frames(self, pins) -> list[Frame]:
        frames = []
        pin_i = 0
        while pin_i < len(pins):
            if pins[pin_i] == STRIKE:
                frames.append(Frame(STRIKE, pin_i))
                pin_i += 1
            else:
                try:
                    frames.append(Frame(pins[pin_i], pin_i, pins[pin_i + 1]))
                    pin_i += 2
                except IndexError:
                    # Missing second roll in frame
                    frames.append(Frame(pins[pin_i], pin_i))
                    pin_i += 1

        return frames
