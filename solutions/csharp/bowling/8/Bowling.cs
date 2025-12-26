
public class FrameValidator
{
    public static void ValidateFrame11Completion(Frame currentFrame, Frame? previousFrame)
    {
        if (currentFrame.frameNumber != BowlingGame.MAX_FRAMES_PER_GAME + 1)
        {
            return;
        }

        if (previousFrame != null && currentFrame.IsEmpty)
        {
            if (previousFrame.IsSpare() || previousFrame.IsStrike())
            {
                throw new ArgumentException();
            }
        }
    }

    public static void ValidateFrame12Completion(Frame currentFrame, Frame? previousFrame)
    {
        if (currentFrame.frameNumber != BowlingGame.MAX_FRAMES_PER_GAME + 2)
        {
            return;
        }

        if (previousFrame == null || !previousFrame.IsStrike() || previousFrame.frameNumber != BowlingGame.MAX_FRAMES_PER_GAME + 1)
        {
            return;
        }

        var frameBeforePrevious = previousFrame.previousFrame;
        if (frameBeforePrevious != null && frameBeforePrevious.IsStrike() && currentFrame.IsEmpty)
        {
            throw new ArgumentException();
        }
    }

    public static void ValidateOpenFrame(Frame currentFrame, List<Frame> frames, Frame? previousFrame)
    {
        if (currentFrame.IsOpen && !currentFrame.IsFull)
        {
            frames.Add(currentFrame);
        }
        if ((currentFrame.frameNumber == BowlingGame.MAX_FRAMES_PER_GAME + 1) && currentFrame.IsOpen)
        {
            if (previousFrame == null || !previousFrame.NeedsBonus())
            {
                throw new ArgumentException();
            }
        }
    }
}

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
            ValidateExtraRoll(previousFrame);
        }
        currentFrame = currentFrame.AddRoll(frames, pins);
    }

    private void ValidateExtraRoll(Frame? previousFrame)
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

    public int? Score()
    {
        if (currentFrame.frameNumber < MAX_FRAMES_PER_GAME)
        {
            throw new ArgumentException();
        }

        var previousFrame = currentFrame.previousFrame;

        FrameValidator.ValidateFrame11Completion(currentFrame, previousFrame);
        FrameValidator.ValidateFrame12Completion(currentFrame, previousFrame);
        FrameValidator.ValidateOpenFrame(currentFrame, frames, previousFrame);

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

        if (IsOpen)
        {
            return AddSecondRoll(frames, pins);
        }

        return AddFirstRoll(frames, pins);
    }

    private Frame AddFirstRoll(List<Frame> frames, int pins)
    {
        roll1Score = pins;
        IsOpen = true;

        if (pins < MAX_PINS_PER_ROLL)
        {
            return this;
        }

        roll2Score = 0;
        return NewFrame(frames);
    }

    private Frame AddSecondRoll(List<Frame> frames, int pins)
    {
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

    private int RawScore() => IsOpen ? roll1Score : roll1Score + roll2Score;

    private int GetSpareBonus() => nextFrame?.roll1Score ?? 0;

    private int GetStrikeBonus()
    {
        if (nextFrame == null) return 0;
        
        var bonus = nextFrame.roll1Score;
        
        if (nextFrame.IsStrike() && nextFrame.nextFrame != null)
        {
            bonus += nextFrame.nextFrame.roll1Score;
        }
        else if (nextFrame.IsFull || !nextFrame.IsOpen)
        {
            bonus += nextFrame.roll2Score;
        }

        return bonus;
    }

    public int Score() 
    {
        if (frameNumber > BowlingGame.MAX_FRAMES_PER_GAME)
        {
            return 0;
        }

        if (IsSpare())
        {
            return RawScore() + GetSpareBonus();
        }

        if (IsStrike())
        {
            var bonus = IsLastFrame() ? GetLastFrameStrikeBonus() : GetStrikeBonus();
            return RawScore() + bonus;
        }

        return RawScore();
    }

    private int GetLastFrameStrikeBonus()
    {
        var bonus = nextFrame?.RawScore() ?? 0;
        var twoFramesAhead = nextFrame?.nextFrame;
        if (twoFramesAhead != null)
        {
            bonus += twoFramesAhead.RawScore();
        }
        return bonus;
    }

}
