defmodule Glific.Questions.Question do
  @moduledoc """
  Schema for the basic question type
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Glific.{

  }

  @required_fields [:label, :shortcode, :type, ]
  @optional_fields [:clean_answer, :validate_answer, :valid_answers, :number_retries, :shortcode_error,
                    :table_name, :column_name, :callback_module, :callback_function]

  @type t() :: $__MODULE__{
    __meta__: Ecto.Schema.Metadata.t(),
    id: non_neg_integer | nil,
    label: String.t() | nil,
    shortcode: String.t() | nil,
    type: String.t() | nil,
    clean_answer: boolean(),
    strip_answer: boolean(),
    validate_answer: boolean(),
    valid_answers: list(),
    number_retries: integer,
    shortcode_error: String.t(),
    table_name: String.t(),
    column_name: String.t(),
    callback_module: String.t(),
    callback_function: String.t(),
    inserted_at: :utc_datetime | nil,
    updated_at: :utc_datetime | nil
  }
end
