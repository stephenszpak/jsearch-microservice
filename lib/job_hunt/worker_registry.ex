defmodule JobHunt.WorkerRegistry do
  use Registry,
    keys: :unique,
    name: __MODULE__
end
