public class LogLevels {

    public static String message(String logLine) {
        String message = logLine.split(":")[1];

        return message.trim();
    }

    public static String logLevel(String logLine) {
        String level = logLine.split(":")[0];

        return level.trim().toLowerCase().replace("[", "").replace("]", "");
    }

    public static String reformat(String logLine) {
        return String.format("%s (%s)", message(logLine), logLevel(logLine));
    }
}
