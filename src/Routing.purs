module Routing
  ( match
  , matchWith
  ) where

import Prelude

import Data.Either (Either)
import Data.Maybe (fromJust)
import JSURI (decodeURIComponent)
import Partial.Unsafe(unsafePartial)
import Routing.Match (Match, runMatch)
import Routing.Parser (parse)

unsafeDecodeURIComponent :: String -> String
unsafeDecodeURIComponent uri =
  unsafePartial $ fromJust $ decodeURIComponent uri

-- | Runs a `Match` parser.
match :: forall a. Match a -> String -> Either String a
match = matchWith unsafeDecodeURIComponent

-- | Runs a `Match` parser given a custom String decoder.
matchWith :: forall a. (String -> String) -> Match a -> String -> Either String a
matchWith decoder matcher = runMatch matcher <<< parse decoder
