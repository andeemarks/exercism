defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(data :: opts) :: {status :: atom, results :: opts}
  @callback handle_frame(dot :: dot, frame :: frame_number, options :: opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame, _) when frame / 4 == trunc(frame / 4) do
    %{dot | opacity: dot.opacity / 2}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, _, _), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    velocity = Keyword.get(opts, :velocity, nil)

    case is_integer(velocity) do
      true ->
        {:ok, opts}

      false ->
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, 1, _), do: dot

  @impl DancingDots.Animation
  def handle_frame(dot, frame, options) do
    growth = (frame - 1) * Keyword.get(options, :velocity)
    %{dot | radius: dot.radius + growth}
  end
end
