"""Solution to Ellen's Alien Game exercise."""


class Alien:
    """Create an Alien object with location x_coordinate and y_coordinate.

    Attributes
    ----------
    (class)total_aliens_created: int
    x_coordinate: int - Position on the x-axis.
    y_coordinate: int - Position on the y-axis.
    health: int - Amount of health points.

    Methods
    -------
    hit(): Decrement Alien health by one point.
    is_alive(): Return a boolean for if Alien is alive (if health is > 0).
    teleport(new_x_coordinate, new_y_coordinate): Move Alien object to new coordinates.
    collision_detection(other): Implementation TBD.
    """

    total_aliens_created = 0

    def __init__(self, init_x, init_y):
        self.x_coordinate = init_x
        self.y_coordinate = init_y
        self.health = 3
        Alien.total_aliens_created = Alien.total_aliens_created + 1

    def hit(self):
        """
        docstring
        """

        self.health = self.health - 1

    def is_alive(self):
        """
        docstring
        """

        return self.health > 0

    def teleport(self, new_x, new_y):
        """
        docstring
        """

        self.x_coordinate = new_x
        self.y_coordinate = new_y

    def collision_detection(self, other):
        """
        docstring
        """


def new_aliens_collection(position_data):
    """
    docstring
    """

    return [Alien(position[0], position[1]) for position in position_data]
