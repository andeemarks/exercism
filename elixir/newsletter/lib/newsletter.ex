defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read()
    |> elem(1)
    |> format_emails()
  end

  defp format_emails(emails) when emails == "", do: []
  defp format_emails(emails) do
    emails
    |> String.trim()
    |> String.split("\n")
  end

  def open_log(path) do
    path
    |> File.open([:write])
    |> elem(1)
  end

  def log_sent_email(pid, email), do: IO.write(pid, email <> "\n")
  def close_log(pid), do: File.close(pid)

  defp send_email(email, send_fun, log_file) do
    if send_fun.(email) == :ok do
      log_sent_email(log_file, email)
    end
  end


  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log_file = open_log(log_path)
    Enum.map(emails, &(send_email(&1, send_fun, log_file)))
    close_log(log_file)
  end
end
