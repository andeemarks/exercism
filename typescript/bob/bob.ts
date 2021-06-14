class Bob {
  hey(originalConversation: string): string {
    const conversation = originalConversation.trim();
    const isQuestion = conversation.endsWith("?");
    const hasLetters = conversation.toLowerCase().match(/[a-z]/) != null;
    const isShouted = hasLetters && conversation.toUpperCase() == conversation;
    const isEmpty = conversation.length === 0;

    if (isEmpty) {
      return "Fine. Be that way!";
    }

    if (isShouted && isQuestion) {
      return "Calm down, I know what I\'m doing!";
    }

    if (isShouted) {
      return "Whoa, chill out!";
    }

    if (isQuestion) {
      return "Sure.";
    }

    return "Whatever.";
  }
}

export default Bob;
