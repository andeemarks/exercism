from enum import Enum, auto

class Action(Enum):
    FILL = auto()
    POUR = auto()
    EMPTY = auto()

class Bucket:
    def __init__(self, size, label):
        self.size = size
        self.litres = 0
        self.label = label

    def fill(self):
        print(f"{self.label} -> filling to {self.size}l")
        self.litres = self.size

    def empty(self):
        print(f"{self.label} -> emptying {self.litres}l")
        self.litres = 0

    def available(self):
        return self.size - self.litres
    
    def pour_into(self, other):
        if self == other:
            raise ValueError("Attempt to pour bucket into itself")
        
        if self.litres <= other.available():
            print(f"{self.label} -> pouring {self.litres}l into {other.label}")
            other.add(self.litres)
            self.empty()
        else:
            pour_amount = other.available()
            print(f"{self.label} -> pouring {pour_amount}l into {other.label}")
            other.add(pour_amount)
            self.remove(pour_amount)

    def add(self, litres):
        self.litres += litres

    def remove(self, litres):
        self.litres -= litres

    def is_full(self):
        return self.litres == self.size

    def is_empty(self):
        return self.litres == 0
    
    def __str__(self):
        return f"{self.label}: {self.litres}l of {self.size}l"
    
def measure(bucket_one, bucket_two, goal, start_bucket):
    bucket_1 = Bucket(bucket_one, "one")
    bucket_2 = Bucket(bucket_two, "two")
    action_count = 0

    if start_bucket == "one":
        # test_measure_using_bucket_one_of_size_3_and_bucket_two_of_size_5_start_with_bucket_one
        action_count = do_action(Action.FILL, bucket_1, None, action_count)
        action_count = do_action(Action.POUR, bucket_1, bucket_2, action_count)
        action_count = do_action(Action.FILL, bucket_1, None, action_count)
        action_count = do_action(Action.POUR, bucket_1, bucket_2, action_count)
    else:
        # test_measure_using_bucket_one_of_size_3_and_bucket_two_of_size_5_start_with_bucket_two
        action_count = do_action(Action.FILL, bucket_2, None, action_count)
        action_count = do_action(Action.POUR, bucket_2, bucket_1, action_count)
        action_count = do_action(Action.EMPTY, bucket_1, None, action_count)
        action_count = do_action(Action.POUR, bucket_2, bucket_1, action_count)
        action_count = do_action(Action.FILL, bucket_2, None, action_count)
        action_count = do_action(Action.POUR, bucket_2, bucket_1, action_count)
        action_count = do_action(Action.EMPTY, bucket_1, None, action_count)
        action_count = do_action(Action.POUR, bucket_2, bucket_1, action_count)

    print(bucket_1, bucket_2, f"goal: {goal}")
    # while bucket_1.litres != goal and bucket_2.litres != goal:
    #     # This is where the magic happens...
    #     action_count += 1

    if bucket_1.litres == goal:
        return (action_count, bucket_1.label, bucket_2.litres)
    elif bucket_2.litres == goal:
        return (action_count, bucket_2.label, bucket_1.litres)

    raise ValueError("Could not solve")

def do_action(action, bucket_1, bucket_2, action_count):
    match action:
        case Action.FILL:
            fill_action(bucket_1)
        case Action.EMPTY:
            empty_action(bucket_1)
        case Action.POUR:
            pour_action(bucket_1, bucket_2)

    return action_count + 1
    
def empty_action(bucket):
    bucket.empty()

def fill_action(bucket):
    bucket.fill()

def pour_action(from_bucket, to_bucket):
    from_bucket.pour_into(to_bucket)

def check_valid_state(start_bucket, other_bucket):
    if start_bucket.is_empty() and other_bucket.is_full():
        raise ValueError("Starting bucket is empty and other bucket is full")