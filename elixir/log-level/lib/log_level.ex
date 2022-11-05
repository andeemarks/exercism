defmodule LogLevel do 
  @levels %{0 => :trace, 1 => :debug, 2 => :info, 3 => :warning, 4 => :error, 5 => :fatal}

  def to_label(level, legacy?) do
    cond do
      level == 0 and legacy? -> :unknown
      level == 0 and not legacy? -> Map.get(@levels, level, :unknown)
      level == 5 and legacy? -> :unknown
      level == 5 and not legacy? -> Map.get(@levels, level, :unknown)
      true -> Map.get(@levels, level, :unknown)
    end
  end

  def alert_recipient(level, _) when level >= 1 and level <= 3 do end
  def alert_recipient(level, legacy?) when level == 0 and not legacy? do end

  def alert_recipient(level, legacy?) do
    cond do
      level == 0 and legacy? -> :dev1
      level == 4 and legacy? -> :ops
      level != 4 and legacy? -> :dev1
      level == 4 and not legacy? -> :ops
      level == 5 and not legacy? -> :ops
      true -> :dev2
    end
  end
end
