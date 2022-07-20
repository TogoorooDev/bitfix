{-# LANGUAGE OverloadedStrings #-}

module Server
( srvInit
) where

import Web.Scotty
--import Data.Monad (mconcat)
import Control.Monad
import Network.HTTP.Req
import qualified Data.ByteString as B

getURL :: B.ByteString -> B.ByteString 
getURL page = do
  r <- 
    req 
      GET
      (https page /: "get")
      ""
      (ignoreResponse)
      (mempty)

  let code = responseStatusCode
  if ((code >= 300) && (code < 400))
  then getURL $ responseHeader r "location"  
  else page

srvInit :: IO ()
srvInit = scotty 3000 $
  get "/" $ do
--    r <- req  GET --method
  --            (https "https://tinyurl.com/3uu4tddt" /: "get")
    --          (mempty)
    
    text $ getURL "https://t.co/Is5aUwyLZC"
