{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_euler_problems (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
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
version = Version [1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "C:\\Users\\abobus\\itmo\\learning\\fp\\lab1\\.stack-work\\install\\4dc0f9e0\\bin"
libdir     = "C:\\Users\\abobus\\itmo\\learning\\fp\\lab1\\.stack-work\\install\\4dc0f9e0\\lib\\x86_64-windows-ghc-9.4.8\\euler-problems-1.0.0-Da0xSTHYwNrIwjHuwvMATy-euler27-test"
dynlibdir  = "C:\\Users\\abobus\\itmo\\learning\\fp\\lab1\\.stack-work\\install\\4dc0f9e0\\lib\\x86_64-windows-ghc-9.4.8"
datadir    = "C:\\Users\\abobus\\itmo\\learning\\fp\\lab1\\.stack-work\\install\\4dc0f9e0\\share\\x86_64-windows-ghc-9.4.8\\euler-problems-1.0.0"
libexecdir = "C:\\Users\\abobus\\itmo\\learning\\fp\\lab1\\.stack-work\\install\\4dc0f9e0\\libexec\\x86_64-windows-ghc-9.4.8\\euler-problems-1.0.0"
sysconfdir = "C:\\Users\\abobus\\itmo\\learning\\fp\\lab1\\.stack-work\\install\\4dc0f9e0\\etc"

getBinDir     = catchIO (getEnv "euler_problems_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "euler_problems_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "euler_problems_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "euler_problems_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "euler_problems_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "euler_problems_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
