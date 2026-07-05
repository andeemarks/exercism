defmodule Ledger do

  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries) do
    Ledger.Header.format(locale) <> Ledger.Entry.format(entries, currency, locale)
  end

  defmodule EntryDate do
    def format(locale, entry_date) do
      year = entry_date.year |> to_string()
      month = entry_date.month |> to_string() |> String.pad_leading(2, "0")
      day = entry_date.day |> to_string() |> String.pad_leading(2, "0")

      format(locale, day, month, year)
    end

    defp format(:en_US, day, mon, year), do:  "#{mon}/#{day}/#{year} "
    defp format(_, day, mon, year), do:       "#{day}-#{mon}-#{year} "
  end

  defmodule Header do
    def format(:en_US), do: "Date       | Description               | Change       \n"
    def format(_), do:      "Datum      | Omschrijving              | Verandering  \n"
  end

  defmodule Entry do
    @locale_settings %{usd: %{currency_symbol: "$"}, eur: %{currency_symbol: "€"}}

    def format([], _currency, _locale), do: ""
    def format(entries, currency, locale) do
        entries =
          Enum.sort(entries, &entry_sorter/2)
          |> Enum.map(&format_entry(&1, currency, locale))
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


    defp format_entry(entry, currency, locale) do
      date = Ledger.EntryDate.format(locale, entry.date)
      symbol = @locale_settings[currency][:currency_symbol]
      number = format_cents(entry.amount_in_cents, locale)
      amount = format_amount(locale, entry.amount_in_cents, symbol, number) |> String.pad_leading(14, " ")
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

    defp format_amount(:en_US, entry_amount_in_cents, symbol, number) when entry_amount_in_cents >= 0 do
      "  #{symbol}#{number} "
    end
    defp format_amount(_, entry_amount_in_cents, symbol, number) when entry_amount_in_cents >= 0 do
      " #{symbol} #{number} "
    end
    defp format_amount(:en_US, _, symbol, number) do
      " (#{symbol}#{number})"
    end
    defp format_amount(_, _, symbol, number) do
      " #{symbol} -#{number} "
    end

    defp format_cents(cents, :en_US), do:  format_cents(cents, ",", ".")
    defp format_cents(cents, _), do:       format_cents(cents, ".", ",")
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
end
