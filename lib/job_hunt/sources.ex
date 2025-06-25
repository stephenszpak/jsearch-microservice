defmodule JobHunt.Sources do
  @callback fetch(map()) :: [%{optional(atom()) => any()}]
end
