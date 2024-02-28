{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Plutarch
import Plutarch.Prelude
import Plutarch.Api.V2
import PlutusLedgerApi.Common
import Data.Default
import qualified Data.ByteString.Base16 as Base16
import qualified Data.ByteString.Short as SBS
import qualified Data.Text.Encoding as Text

import Plutarch.Extra.AssetClass

alwaysPass :: Term s (PInteger :--> PMintingPolicy)
alwaysPass = plam $ \_ _ _ -> popaque $ pconstant $ AssetClass "aa" "hello"

main :: IO ()
main =
  case compile def alwaysPass of
    Right scr@(Script x) -> do
      print $ Text.decodeUtf8 $ Base16.encode $ SBS.fromShort $ serialiseUPLC x
      print $ scriptHash scr
    _ -> putStrLn "no"
