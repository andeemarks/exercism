package parsinglogfiles

import (
	"fmt"
	"regexp"
)

func IsValidLine(text string) bool {
	re := regexp.MustCompile(`^\[(ERR|TRC|DBG|INF|WRN|FTL)\].*`)

	return re.MatchString(text)
}

func SplitLogLine(text string) []string {
	re := regexp.MustCompile(`<[~*=-]*>`)

	return re.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	re := regexp.MustCompile("(?i)" + `\".*password.*\"`)

	passwordCount := 0
	for i := 0; i < len(lines); i++ {
		if re.FindString(lines[i]) != "" {
			passwordCount++
		}
	}

	return passwordCount
}

func RemoveEndOfLineText(text string) string {
	re := regexp.MustCompile(`end-of-line[\d]+`)

	return re.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	re := regexp.MustCompile(`User[ ]+([\w]*)`)
	results := make([]string, len(lines))
	for i := 0; i < len(lines); i++ {
		matches := re.FindStringSubmatch(lines[i])
		userNameFound := len(matches) > 0
		if userNameFound {
			results[i] = fmt.Sprintf("[USR] %s %s", matches[1], lines[i])
		} else {
			results[i] = lines[i]
		}
	}

	return results
}
