from functools import reduce
from dataclasses import dataclass

STRIKE = 10
@dataclass
class Frame:
    first_pin: int
    second_pin: int = 0
    bonus_pin: int = 0

    def total(self) -> int:
        return self.first_pin + self.second_pin + self.bonus_pin

class BowlingGame:
    def __init__(self):
        self.frame_pins = []
        self.frame_scores = []
        self.is_first_roll = True
        self.first_roll_pins = None
        self.pending_bonus = None
        self.is_after_spare = False
        self.last_frame_spare = False
        self.is_frame_following_strike = False

    def handle_first_roll(self, pins):
        if pins == STRIKE:
            if self.is_frame_following_strike:
                self.frame_pins.append(Frame(STRIKE, STRIKE))
            else:
                self.frame_pins.append(Frame(STRIKE))            

            self.is_frame_following_strike = True
            print(f"is_frame_following_strike in frame {len(self.frame_pins)}")

        else:
            if self.last_frame_spare:
                print(f"last frame spare with {pins}")
                self.frame_pins.append(Frame(pins))    
            else:
                self.first_roll_pins = pins
                if self.is_after_spare or self.is_frame_following_strike:
                    print(f"setting bonus to {pins}")
                    self.pending_bonus = pins
                else:
                    self.pending_bonus = 0

            self.is_first_roll = False

    def handle_second_roll(self, pins):
        print(self.is_frame_following_strike)
        if self.is_frame_following_strike:
            print(f"frame following strike bonus of {self.pending_bonus + pins}")
            self.frame_pins.append(Frame(self.first_roll_pins, pins, self.pending_bonus + pins))
            self.is_frame_following_strike = False
        else:
            self.frame_pins.append(Frame(self.first_roll_pins, pins, self.pending_bonus))
        self.is_after_spare = self.first_roll_pins + pins == 10
        self.is_first_roll = True
        print(len(self.frame_pins))
        self.last_frame_spare = self.is_after_spare and len(self.frame_pins) == 10

    def roll(self, pins):
        if self.is_first_roll:
            self.handle_first_roll(pins)
        else:
            self.handle_second_roll(pins)

    def score(self):
        print(self.frame_pins)

        return sum(list(map(lambda frame: frame.total() , self.frame_pins)))
