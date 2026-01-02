using System.Collections.Immutable;
using System.Reactive.Subjects;
using System.Reactive.Linq;
using System.Reactive.Disposables;

public class HangmanState(string maskedWord, ImmutableHashSet<char> guessedChars, int remainingGuesses)
{
    public string MaskedWord { get; } = maskedWord;
    public ImmutableHashSet<char> GuessedChars { get; } = guessedChars;
    public int RemainingGuesses { get; } = remainingGuesses;
}

public class TooManyGuessesException : Exception
{
}

public class Hangman
{
    private readonly string _word;
    private readonly Subject<HangmanState> _stateSubject;
    private string _maskedWord;
    private ImmutableHashSet<char> _guessedChars;
    private int _remainingGuesses;
    private bool _gameOver;
    private HangmanState? _lastState;

    public IObservable<HangmanState> StateObservable => Observable.Create<HangmanState>(observer =>
    {
        return _gameOver ? HandleGameOver(observer) : NotifyObserver(observer);
    });

    private IDisposable NotifyObserver(IObserver<HangmanState> observer)
    {
        if (_lastState != null)
        {
            observer.OnNext(_lastState);
        }
        return _stateSubject.Subscribe(observer);
    }

    private IDisposable HandleGameOver(IObserver<HangmanState> observer)
    {
        if (!_maskedWord.Contains('_'))
        {
            observer.OnCompleted();
        }
        else
        {
            observer.OnError(new TooManyGuessesException());
        }
        return Disposable.Empty;
    }

    public IObserver<char> GuessObserver { get; }

    public Hangman(string word)
    {
        _word = word.ToLower();
        _maskedWord = new string('_', word.Length);
        _guessedChars = ImmutableHashSet<char>.Empty;
        _remainingGuesses = 9;
        _gameOver = false;
        _lastState = null;

        _stateSubject = new Subject<HangmanState>();

        EmitState();

        GuessObserver = new GuessObserverImpl(this);
    }

    private void OnGuess(char guess)
    {
        if (_gameOver) return;

        guess = char.ToLower(guess);

        // Check if game is already at the limit
        if (_remainingGuesses == 0)
        {
            _gameOver = true;
            _stateSubject.OnError(new TooManyGuessesException());
            return;
        }

        // Check if already guessed
        bool alreadyGuessed = _guessedChars.Contains(guess);

        // Add to guessed chars
        _guessedChars = _guessedChars.Add(guess);

        if (alreadyGuessed)
        {
            // Duplicate guess - counts as failure
            _remainingGuesses--;
        }
        else if (_word.Contains(guess))
        {
            // Correct guess - unmask letters
            var chars = _maskedWord.ToCharArray();
            for (int i = 0; i < _word.Length; i++)
            {
                if (_word[i] == guess)
                {
                    chars[i] = guess;
                }
            }
            _maskedWord = new string(chars);
            // Don't decrement for correct guess
        }
        else
        {
            // Wrong guess
            _remainingGuesses--;
        }

        // Check if won
        if (!_maskedWord.Contains('_'))
        {
            _gameOver = true;
            _stateSubject.OnCompleted();
        }
        else
        {
            // Emit state only if not completed
            EmitState();
        }
    }

    private void EmitState()
    {
        _lastState = new HangmanState(_maskedWord, _guessedChars, _remainingGuesses);
        _stateSubject.OnNext(_lastState);
    }

    private class GuessObserverImpl(Hangman hangman) : IObserver<char>
    {
        private readonly Hangman _hangman = hangman;

        public void OnNext(char value)
        {
            _hangman.OnGuess(value);
        }

        public void OnError(Exception error)
        {
            // Not used
        }

        public void OnCompleted()
        {
            // Not used
        }
    }
}
