import java.util.ArrayList;
import java.util.List;

class Series {
    private String string = "";

    Series(String string) {
        this.string = string;
    }

    List<String> slices(int sliceLength) {
        checkForValidSliceLength(sliceLength);

        List<String> foundSeries = new ArrayList<String>();
        for (int i = 0; i <= string.length() - sliceLength; i++) {
            foundSeries.add(string.substring(i, i + sliceLength));
        }

        return foundSeries;
    }

    private void checkForValidSliceLength(int sliceLength) {
        if (sliceLength > string.length()) {
            throw new IllegalArgumentException("Slice size is too big.");
        }

        if (sliceLength <= 0) {
            throw new IllegalArgumentException("Slice size is too small.");
        }
    }
}
