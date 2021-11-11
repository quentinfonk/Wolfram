{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_azerty (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/quentinfonk/github/Wolfram/.stack-work/install/x86_64-linux-tinfo6/f92419f7a063005c5a1080cd6ac87b7c4e02530dbf05fbbc32a11c80b715475d/8.8.4/bin"
libdir     = "/home/quentinfonk/github/Wolfram/.stack-work/install/x86_64-linux-tinfo6/f92419f7a063005c5a1080cd6ac87b7c4e02530dbf05fbbc32a11c80b715475d/8.8.4/lib/x86_64-linux-ghc-8.8.4/azerty-0.1.0.0-23woXsMDW1PIf19EJ8eTsF-azerty-test"
dynlibdir  = "/home/quentinfonk/github/Wolfram/.stack-work/install/x86_64-linux-tinfo6/f92419f7a063005c5a1080cd6ac87b7c4e02530dbf05fbbc32a11c80b715475d/8.8.4/lib/x86_64-linux-ghc-8.8.4"
datadir    = "/home/quentinfonk/github/Wolfram/.stack-work/install/x86_64-linux-tinfo6/f92419f7a063005c5a1080cd6ac87b7c4e02530dbf05fbbc32a11c80b715475d/8.8.4/share/x86_64-linux-ghc-8.8.4/azerty-0.1.0.0"
libexecdir = "/home/quentinfonk/github/Wolfram/.stack-work/install/x86_64-linux-tinfo6/f92419f7a063005c5a1080cd6ac87b7c4e02530dbf05fbbc32a11c80b715475d/8.8.4/libexec/x86_64-linux-ghc-8.8.4/azerty-0.1.0.0"
sysconfdir = "/home/quentinfonk/github/Wolfram/.stack-work/install/x86_64-linux-tinfo6/f92419f7a063005c5a1080cd6ac87b7c4e02530dbf05fbbc32a11c80b715475d/8.8.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "azerty_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "azerty_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "azerty_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "azerty_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "azerty_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "azerty_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
