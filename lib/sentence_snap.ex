defmodule SentenceSnap do
  @min_sentence_length 100

  def read_and_process(file) do
    file
    |> File.read!()
    |> normalize_whitespace()
    |> split_sentences()
    |> Enum.filter(&(String.length(&1) > @min_sentence_length))
    |> Enum.with_index(1)
    |> Enum.map(&process_sentence(&1))
    |> Jason.encode!()
    |> write_to_file("output.json")
  end

  defp normalize_whitespace(text) do
    text
    |> String.replace(~r/\n/, " ")
    |> String.replace(~r/\s+/, " ")
  end

  defp split_sentences(text) do
    Regex.split(~r/(?<=\.|\?|\!|\.\.\.|!\?\!)/, text)
    |> Enum.map(&String.trim(&1))
    |> Enum.reject(&(&1 == ""))
  end

  defp process_sentence({sentence, id}) do
    %{
      "id" => id,
      "text" => sentence,
      "length" => String.length(sentence)
    }
  end

  defp write_to_file(json_data, filename) do
    File.write!(filename, json_data)
  end
end

SentenceSnap.read_and_process("sentences.txt")
