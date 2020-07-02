defmodule Glific.Questions do
  @moduledoc """
  The interface for all our survey functionality. We want to avoid making this too complex.
  If it gets too complex, we should spin it off into its own application
  """

  import Ecto.Query, warn: false
  alias Glific.Repo

  alias Glific.Questions.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  @spec list_questions(map()) :: [Question.t()]
  def list_questions(_attrs) do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_question!(integer) :: Question.t()
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_question(map()) :: {:ok, Question.t()} | {:error, Ecto.Changeset.t()}
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_question(Question.t(), map()) :: {:ok, Question.t()} | {:error, Ecto.Changeset.t()}
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_question(Question.t()) :: {:ok, Question.t()} | {:error, Ecto.Changeset.t()}
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  @spec change_question(Question.t(), map()) :: Ecto.Changeset.t()
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end


  def process_message(question, message) do
      body = message.body
      state = % { question: question, message: message}

      perform_checks(state, message, [])
        |> case do
          {:ok, state} -> do_something_with_state(...)
          {:error, reason} -> do_something_with_error(...)
      end
  end

  defp get_checks(question) do
    list =
    if question.clean_answer do
      [&clean_answer/1]
    else
      []
    end


    if question.validate_answer do
      list = list ++ [&validate_answer/1]
    end

  end

  defp perform_checks(state, []), do: {:ok, state}

  defp perform_checks(state, [check_fun | remaining_checks]) do
    case check_fun.(state) do
      {:ok, new_state} -> perform_checks(new_state, remaining_checks)
      {:error, _} = error -> error
    end
  end

  defp clean_answer(state) do
    body =
    state.message.body
    |> String.replace(~r/[\p{P}\p{S}\p{Z}\p{C}]+/u, "")
    |> String.downcase()
    |> String.trim()

    {:ok, put_in(state, [:message, :body], body)}
  end

  defp validate_answer(state) do

  end


end
