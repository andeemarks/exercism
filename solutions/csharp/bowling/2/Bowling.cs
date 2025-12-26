
public class BowlingGame
{
    private readonly List<Frame> frames = [];
    private Frame currentFrame = new();
    public static readonly int MAX_FRAMES_PER_GAME = 10;

    public void Roll(int pins) 
    {
        var previousFrame = currentFrame.previousFrame;
        if (currentFrame.frameNumber > MAX_FRAMES_PER_GAME)
        {
            if (previousFrame == null || !(previousFrame.IsStrike() || previousFrame.IsSpare()))
            {
                throw new ArgumentException();
            }
            if (previousFrame.IsSpare() && currentFrame.IsOpen)
            {
                throw new ArgumentException();
            }
        }
        currentFrame = currentFrame.AddRoll(frames, pins);
    }

    public int? Score()
    {
        if (currentFrame.frameNumber < MAX_FRAMES_PER_GAME)
        {
            throw new ArgumentException();
        }

        var previousFrame = currentFrame.previousFrame;

        if (currentFrame.frameNumber == MAX_FRAMES_PER_GAME + 1)
        {
            if (previousFrame != null && previousFrame.IsSpare() && currentFrame.IsEmpty)
            {
                throw new ArgumentException();
            }
            if (previousFrame != null && previousFrame.IsStrike() && currentFrame.IsEmpty)
            {
                throw new ArgumentException();
            }
        }

        if (currentFrame.frameNumber == MAX_FRAMES_PER_GAME + 2)
        {
            // Frame 10 was a strike and frame 11's first roll was also a strike
            if (previousFrame != null && previousFrame.IsStrike() && previousFrame.frameNumber == MAX_FRAMES_PER_GAME + 1)
            {
                // We have frame 10 (strike), frame 11 (strike), now need to check frame 12
                var frameBeforePrevious = previousFrame.previousFrame;
                if (frameBeforePrevious != null && frameBeforePrevious.IsStrike())
                {
                    if (currentFrame.IsEmpty)
                    {
                        throw new ArgumentException();
                    }
                }
            }
        }

        if (currentFrame.IsOpen && !currentFrame.IsFull)
        {
            frames.Add(currentFrame);
        }
        if ((currentFrame.frameNumber == MAX_FRAMES_PER_GAME + 1) && currentFrame.IsOpen)
        {
            if (previousFrame == null || !previousFrame.NeedsBonus())
            {
                throw new ArgumentException();
            }
        }

        return frames.Sum(frame => frame.Score());
    }
}

public class Frame(int frameNumber, Frame? previous = null)
{
    public Frame() : this(1) {}

    public int roll1Score { get; set; } = 0;
    public int roll2Score { get; set; } = 0;
    public int frameNumber { get; private set; } = frameNumber;
    public Frame? previousFrame { get; private set; } = previous;
    public Frame? nextFrame { get; private set; }

    public bool IsFull { get; private set; } = false;
    public bool IsEmpty { get; private set; } = true;
    public bool IsOpen { get; private set; } = false;

    public bool IsSpare() => IsFull && RawScore() == MAX_PINS_PER_ROLL && roll1Score != MAX_PINS_PER_ROLL;
    public bool IsStrike() => roll1Score == MAX_PINS_PER_ROLL;
    public bool IsLastFrame() => frameNumber == BowlingGame.MAX_FRAMES_PER_GAME;
    public bool NeedsBonus() => IsStrike() || IsSpare();

    private static readonly int MAX_PINS_PER_ROLL = 10;

    public Frame AddRoll(List<Frame> frames, int pins)
    {
        if (pins < 0 || pins > MAX_PINS_PER_ROLL)
        {
            throw new ArgumentException();
        }

        IsEmpty = false;

        if (!IsOpen)
        {
            if (pins < MAX_PINS_PER_ROLL)
            {
                roll1Score = pins;
                IsOpen = true;
                return this;
            }

            if (pins == MAX_PINS_PER_ROLL)
            {
                roll1Score = pins;
                IsOpen = true;
                roll2Score = 0;
                return NewFrame(frames);
            }
        }

        if (roll1Score + pins > MAX_PINS_PER_ROLL)
        {
            throw new ArgumentException();
        }

        roll2Score = pins;
        IsOpen = false;
        IsFull = true;
        return NewFrame(frames);
    }

    private Frame NewFrame(List<Frame> frames)
    {
        frames.Add(this);
        Frame nextFrame = new(frameNumber + 1, this);
        this.nextFrame = nextFrame;

        return nextFrame;
    }

    private int RawScore()
    {
        if (IsOpen)
        {
            return roll1Score;
        }

        return roll1Score + roll2Score;
    }

    public int Score() 
    {
        if (frameNumber > BowlingGame.MAX_FRAMES_PER_GAME)
        {
            return 0;
        }

        if (IsSpare())
        {
            if (nextFrame != null)
            {
                return RawScore() + nextFrame.roll1Score;
            }
        }

        if (IsStrike())
        {
            if (nextFrame != null)
            {
                var nextFrame = this.nextFrame;
                if (IsLastFrame())
                {
                    var twoFramesAhead = nextFrame.nextFrame;
                    if (twoFramesAhead != null)
                    {
                        return RawScore() + nextFrame.RawScore() + twoFramesAhead.RawScore();
                    }
                    return RawScore() + nextFrame.RawScore();
                }
                // For strikes, add the raw scores of the next two rolls
                var bonusScore = nextFrame.roll1Score;
                if (nextFrame.IsStrike() && nextFrame.nextFrame != null)
                {
                    bonusScore += nextFrame.nextFrame.roll1Score;
                }
                else if (nextFrame.IsFull || !nextFrame.IsOpen)
                {
                    bonusScore += nextFrame.roll2Score;
                }

                return RawScore() + bonusScore;
            }
        }

        return RawScore();
    }

}
