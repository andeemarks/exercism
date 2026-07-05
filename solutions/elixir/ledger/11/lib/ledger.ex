defmodule Ledger do
  @doc """
  Format the given entries given a currency and locale
  """
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(currency, locale, entries) do
    header = format_header(locale)

    format_entries(entries, header, currency, locale)
  end

  defp format_entries([], header, _currency, _locale), do: header
  defp format_entries(entries, header, currency, locale) do
      entries =
        Enum.sort(entries, fn a, b ->
          cond do
            a.date.day < b.date.day -> true
            a.date.day > b.date.day -> false
            a.description < b.description -> true
            a.description > b.description -> false
            true -> a.amount_in_cents <= b.amount_in_cents
          end
        end)
        |> Enum.map(&format_entry(&1, currency, locale))
        |> Enum.join("\n")

      header <> entries <> "\n"
  end

  defp format_header(:en_US), do: "Date       | Description               | Change       \n"
  defp format_header(_), do: "Datum      | Omschrijving              | Verandering  \n"

  defp format_entry(entry, currency, locale) do
    date = format_date(locale, entry.date)

    number = format_number(locale, entry.amount_in_cents)

    amount = format_amount(locale, entry.amount_in_cents, currency, number)

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

  defp format_amount(locale, entry_amount_in_cents, currency, number) do
      if entry_amount_in_cents >= 0 do
        if locale == :en_US do
          "  #{if(currency == :eur, do: "€", else: "$")}#{number} "
        else
          " #{if(currency == :eur, do: "€", else: "$")} #{number} "
        end
      else
        if locale == :en_US do
          " (#{if(currency == :eur, do: "€", else: "$")}#{number})"
        else
          " #{if(currency == :eur, do: "€", else: "$")} -#{number} "
        end
      end
      |> String.pad_leading(14, " ")
  end

  defp format_number(locale, entry_amount_in_cents) do
    if locale == :en_US do
      decimal = format_decimal(entry_amount_in_cents)

      whole =
        if abs(div(entry_amount_in_cents, 100)) < 1000 do
          abs(div(entry_amount_in_cents, 100)) |> to_string()
        else
          to_string(div(abs(div(entry_amount_in_cents, 100)), 1000)) <>
            "," <> to_string(rem(abs(div(entry_amount_in_cents, 100)), 1000))
        end

      whole <> "." <> decimal
    else
      decimal = format_decimal(entry_amount_in_cents)

      whole =
        if abs(div(entry_amount_in_cents, 100)) < 1000 do
          abs(div(entry_amount_in_cents, 100)) |> to_string()
        else
          to_string(div(abs(div(entry_amount_in_cents, 100)), 1000)) <>
            "." <> to_string(rem(abs(div(entry_amount_in_cents, 100)), 1000))
        end

      whole <> "," <> decimal
    end
  end

  defp format_decimal(entry_amount_in_cents) do
    entry_amount_in_cents |> abs |> rem(100) |> to_string() |> String.pad_leading(2, "0")
  end

  defp format_date(locale, entry_date) do
    year = entry_date.year |> to_string()
    month = entry_date.month |> to_string() |> String.pad_leading(2, "0")
    day = entry_date.day |> to_string() |> String.pad_leading(2, "0")


    if locale == :en_US do
      month <> "/" <> day <> "/" <> year <> " "
    else
      day <> "-" <> month <> "-" <> year <> " "
    end
  end
end
