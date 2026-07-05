defmodule Ledger do

  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries) do
    header = Ledger.Header.format_header(locale)

    format_entries(entries, header, currency, locale)

  end

  defp format_entries([], header, _currency, _locale), do: header
  defp format_entries(entries, header, currency, locale) do
      entries =
        Enum.sort(entries, &entry_sorter/2)
        |> Enum.map(&format_entry(&1, currency, locale))
        |> Enum.join("\n")

      header <> entries <> "\n"
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
    date = Ledger.EntryDate.format_date(locale, entry.date)
    symbol = currency_symbol(currency)
    number = format_number(entry.amount_in_cents, locale)
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

  defp currency_symbol(:eur), do: "€"
  defp currency_symbol(:usd), do: "$"

  defp format_number(entry_amount_in_cents, :en_US) do
    decimal = format_decimal(entry_amount_in_cents)
    whole = format_whole(entry_amount_in_cents, ",")

    whole <> "." <> decimal
  end
  defp format_number(entry_amount_in_cents, _) do
    decimal = format_decimal(entry_amount_in_cents)
    whole = format_whole(entry_amount_in_cents, ".")

    whole <> "," <> decimal
  end

  defp format_whole(entry_amount_in_cents, separator) do
    dollars = abs(div(entry_amount_in_cents, 100))
    if dollars < 1000 do
      dollars |> to_string()
    else
      to_string(div(dollars, 1000)) <> separator <> to_string(rem(dollars, 1000))
    end
  end

  defp format_decimal(entry_amount_in_cents) do
    entry_amount_in_cents |> abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")
  end


  defmodule EntryDate do

    def format_date(locale, entry_date) do
      year = entry_date.year |> to_string()
      month = entry_date.month |> to_string() |> String.pad_leading(2, "0")
      day = entry_date.day |> to_string() |> String.pad_leading(2, "0")

      format_date(locale, day, month, year)
    end

    defp format_date(:en_US, day, month, year) do
      month <> "/" <> day <> "/" <> year <> " "
    end
    defp format_date(_, day, month, year) do
      day <> "-" <> month <> "-" <> year <> " "
    end

  end

  defmodule Header do
    def format_header(:en_US), do: "Date       | Description               | Change       \n"
    def format_header(_), do:      "Datum      | Omschrijving              | Verandering  \n"
  end
end
