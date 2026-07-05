defmodule Ledger do

  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  defmodule Locale do
    def settings(:en_US) do
      %{thousands_separator: ",",
      header: "Date       | Description               | Change       \n",
      date_separator: "/",
      format_date: fn day, month, year -> "#{month}/#{day}/#{year} " end,
      format_amount: fn entry_amount_in_cents, symbol, number when entry_amount_in_cents >= 0 -> "  #{symbol}#{number} "
                     _, symbol, number -> " (#{symbol}#{number})"
      end,

      cents_separator: "."}
    end
    def settings(:nl_NL) do
      %{thousands_separator: ".",
      header: "Datum      | Omschrijving              | Verandering  \n",
      date_separator: "-",
      format_date: fn day, month, year -> "#{day}-#{month}-#{year} " end,
      format_amount: fn entry_amount_in_cents, symbol, number when entry_amount_in_cents >= 0 -> " #{symbol} #{number} "
                     _, symbol, number -> " #{symbol} -#{number} "
      end,
      cents_separator: ","}
    end
  end

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries) do
    settings = Ledger.Locale.settings(locale)
    settings[:header] <> Ledger.Entry.format(entries, currency, settings)
  end

  defmodule Entry do
    def format([], _currency, _settings), do: ""
    def format(entries, currency, settings) do
      entries =
        Enum.sort(entries, &entry_sorter/2)
        |> Enum.map(&format_entry(&1, currency, settings))
        |> Enum.join("\n")

        entries <> "\n"
      end

      defp entry_sorter(a, b) do
        cond do
          a.date.day < b.date.day -> true
          a.date.day > b.date.day -> false
          a.description < b.description -> true
          a.description > b.description -> false
          true -> a.amount_in_cents <= b.amount_in_cents
        end
      end


      defp format_entry(entry, currency, settings) do
        date = Ledger.EntryDate.format(entry.date, settings[:format_date])
        symbol = %{ usd: %{symbol: "$"}, eur: %{symbol: "€"}}[currency][:symbol]
        thousands_separator = settings[:thousands_separator]
        cents_separator = settings[:cents_separator]
        number = format_cents(entry.amount_in_cents, thousands_separator, cents_separator)
        amount = settings[:format_amount].(entry.amount_in_cents, symbol, number) |> String.pad_leading(14, " ")
        description = format_description(entry.description)

        date <> "|" <> description <> " |" <> amount
      end

      defp format_description(description) do
        if description |> String.length() > 26 do
          " " <> String.slice(description, 0, 22) <> "..."
        else
          " " <> String.pad_trailing(description, 25, " ")
        end
      end

      defp format_cents(cents, thousands_separator, cents_separator) do
        format_whole(cents, thousands_separator) <> cents_separator <> format_decimal(cents)
      end

      defp format_whole(cents, separator) do
        dollars = abs(div(cents, 100))
        if dollars < 1000 do
          dollars |> to_string()
        else
          to_string(div(dollars, 1000)) <> separator <> to_string(rem(dollars, 1000))
        end
      end

      defp format_decimal(cents) do
        cents |> abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")
      end

    end

    defmodule EntryDate do
      def format(entry_date, formatter) do
        year = entry_date.year |> to_string()
        month = entry_date.month |> to_string() |> String.pad_leading(2, "0")
        day = entry_date.day |> to_string() |> String.pad_leading(2, "0")

        formatter.(day, month, year)
      end

    end
  end
