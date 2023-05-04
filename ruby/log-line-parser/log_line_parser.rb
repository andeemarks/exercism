class LogLineParser
  def initialize(line)
    @components = line.split
  end

  def message
    @components.drop(1).join(" ")
  end

  def log_level
    @components
      .first
      .gsub("[","")
      .gsub("]","")
      .gsub(":","")
      .downcase
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
