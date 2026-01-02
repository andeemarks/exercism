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
        _guessedChars = [];
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

        bool isDuplicateGuess = _guessedChars.Contains(guess);
        _guessedChars = _guessedChars.Add(guess);
        var isCorrectGuess = _word.Contains(guess);

        if (isDuplicateGuess)
        {
            _remainingGuesses--;
        }
        else if (isCorrectGuess)
        {
            var chars = MarkCorrectGuessCharsInWord(guess);
            _maskedWord = new string(chars);
        }
        else
        {
            _remainingGuesses--;
        }

        CheckWinState();
    }

    private char[] MarkCorrectGuessCharsInWord(char guess)
    {
        return [.. _maskedWord.Select((c, i) => _word[i] == guess ? guess : c)];
    }

    private void CheckWinState()
    {
        var isCompleted = _maskedWord.Contains('_');
        if (!isCompleted)
        {
            _gameOver = true;
            _stateSubject.OnCompleted();
        }
        else
        {
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
        public void OnNext(char value) => _hangman.OnGuess(value);

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
public class TooManyGuessesException : Exception
{
}
