package scale

import (
	"fmt"
	"strings"
)

func refineNotesForScale(notesForScale []string, tonic string, interval string) []string {
	for i := range notesForScale {
		if strings.ToUpper(notesForScale[i]) == strings.ToUpper(tonic) {
			return notesForScale[i : i+maxNoteSetSize]
		}
	}
	panic(fmt.Sprintln("Could not find notes for scale tonic: " + tonic))
}

func convertIntervalToNoteOffsets(notesForScale []string, interval string) []int {
	scaleNoteOffsetsFromInterval := make([]int, len(interval))

	for pos, char := range interval {
		scaleNoteOffsetsFromInterval[pos] = intervalNoteOffsetMap[char]
	}

	return scaleNoteOffsetsFromInterval
}

func selectNotesFromScale(notesForScale []string, interval string) []string {
	var noteOffsets = convertIntervalToNoteOffsets(notesForScale, interval)

	selectedNotes := make([]string, len(interval))
	var currentOffsetIndex int
	for pos, offset := range noteOffsets {
		selectedNotes[pos] = notesForScale[currentOffsetIndex]
		currentOffsetIndex = currentOffsetIndex + offset
	}

	return selectedNotes
}

func findNotesForTonic(tonic string) []string {
	var notesForTonic, notesFound = scaleSharpFlatMap[tonic]
	if notesFound == false {
		notesForTonic, notesFound = scaleSharpFlatMap[strings.Title(tonic)]
		if notesFound == false {
			notesForTonic, notesFound = scaleSharpFlatMap[strings.ToLower(tonic)]
			if notesFound == false {
				panic(fmt.Sprintln("Could not find notes for scale tonic: " + tonic))

			}
		}
	}

	return notesForTonic
}

// Scale generates a full musical scale starting from the tonic and following the pattern provided by interval
func Scale(tonic string, interval string) []string {
	if interval == "" {
		interval = defaultIntervalPattern
	}

	var notesForScale = refineNotesForScale(findNotesForTonic(tonic), tonic, interval)

	return selectNotesFromScale(notesForScale, interval)
}

const maxNoteSetSize int = 12
const defaultIntervalPattern string = "mmmmmmmmmmmm"

var intervalNoteOffsetMap = map[int32]int{
	'M': 2,
	'A': 3,
	'm': 1,
}

var scaleSharpFlatMap = map[string][]string{
	"C":          chromaticScaleWithSharps,
	"A minor":    chromaticScaleWithSharps,
	"G":          chromaticScaleWithSharps,
	"D":          chromaticScaleWithSharps,
	"A":          chromaticScaleWithSharps,
	"E":          chromaticScaleWithSharps,
	"B":          chromaticScaleWithSharps,
	"F# major e": chromaticScaleWithSharps,
	"f#":         chromaticScaleWithSharps,
	"C#":         chromaticScaleWithSharps,
	"G#":         chromaticScaleWithSharps,
	"D# minor":   chromaticScaleWithSharps,
	"F":          chromaticScaleWithFlats,
	"Bb":         chromaticScaleWithFlats,
	"Eb":         chromaticScaleWithFlats,
	"Ab":         chromaticScaleWithFlats,
	"Db":         chromaticScaleWithFlats,
	"Gb major d": chromaticScaleWithFlats,
	"g":          chromaticScaleWithFlats,
	"d":          chromaticScaleWithFlats,
	"c":          chromaticScaleWithFlats,
	"Eb minor":   chromaticScaleWithFlats,
}

var chromaticScaleWithSharps = []string{
	"A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#",
	"A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G",
}

var chromaticScaleWithFlats = []string{
	"A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab",
	"A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G",
}
