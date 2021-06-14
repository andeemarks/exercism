class Isogram {
    static isIsogram( word: string ): boolean {
        let lowerCaseCharsOnly = word.toLowerCase().match(/[a-z]/g);
        let uniqueChars = new Set(lowerCaseCharsOnly);
        
        return (lowerCaseCharsOnly || "").length === uniqueChars.size;
    }
}

export default Isogram
