| command |command := '([\w\-]+)\s([\w\s]+)' asRegex.command search: ': foo dup ;'.command subexpression: 2.command subexpression: 3."command matchesIn: ': countup 1 2 3 ;'.""command matchesIn: ': foo dup ;'."