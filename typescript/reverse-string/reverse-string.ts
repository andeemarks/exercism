class ReverseString {
    static reverse( source: string ): string {
        let destination = ""
        for(let i = source.length; i>=0; i--) {
            destination = destination.concat(source.charAt(i))
        }
        return destination
    }
}

export default ReverseString
