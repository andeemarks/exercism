class Tag {
    readonly opening: string;
    readonly closing: string;
    counter: number = 0;

    foundOpening() {
        this.counter++;
    }

    foundClosing() {
        this.counter--;
    }

    foundMismatch() {
        this.counter = -1;
    }

    isPaired() {
        return this.counter == 0;
    }

    constructor(opening: string, closing: string) {
        this.opening = opening;
        this.closing = closing;
    }
}

class MatchingBrackets {
    paren: Tag = new Tag("(", ")");
    bracket: Tag = new Tag("[", "]");
    brace: Tag = new Tag("{", "}");
    stack: Array<String> = [];

    handleOpeningTag(tag: Tag) {
        tag.foundOpening();
        this.stack.push(tag.opening);

    }

    matchingOpenTag(tag: Tag): boolean {
        return this.stack[this.stack.length - 1] == tag.opening;
    }

    handleClosingTag(tag: Tag): boolean {
        if (this.matchingOpenTag(tag)) {
            tag.foundClosing();
            this.stack.pop();

            return false;
        } else {
            tag.foundMismatch();

            return true;
        }
    }

    constructor(str: String) {
        let shortCircuit: boolean = false;
        for (let char of str) {
            
            if (shortCircuit) return;

            switch (char) {
                case this.bracket.opening: {
                    this.handleOpeningTag(this.bracket);
                    break;
                }
                case this.bracket.closing: {
                    shortCircuit = this.handleClosingTag(this.bracket);
                    break;
                }
                case this.paren.opening: {
                    this.handleOpeningTag(this.paren);
                    break;
                }
                case this.paren.closing: {
                    shortCircuit = this.handleClosingTag(this.paren);
                    break;
                }
                case this.brace.opening: {
                    this.handleOpeningTag(this.brace);
                    break;
                }
                case this.brace.closing: {
                    shortCircuit = this.handleClosingTag(this.brace);
                    break;
                }
            }
            // console.log(`${this.paren.counter} ${this.brace.counter} ${this.bracket.counter}`);
        }
    }

    isPaired(): boolean {
        return this.brace.isPaired() && this.paren.isPaired() && this.bracket.isPaired();
    }
}

export default MatchingBrackets;