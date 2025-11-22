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
bindir     = "/Users/trikesh/Projects/fp_lab1/.stack-work/install/aarch64-osx/3c9cc461e16c32702af42fff8c7fbdc4f496aad09686229fb59a2d0e75969e52/9.4.8/bin"
libdir     = "/Users/trikesh/Projects/fp_lab1/.stack-work/install/aarch64-osx/3c9cc461e16c32702af42fff8c7fbdc4f496aad09686229fb59a2d0e75969e52/9.4.8/lib/aarch64-osx-ghc-9.4.8/euler-problems-1.0.0-L1Vt9jgWQlT4UhXJ8vUlgw-euler27-test"
dynlibdir  = "/Users/trikesh/Projects/fp_lab1/.stack-work/install/aarch64-osx/3c9cc461e16c32702af42fff8c7fbdc4f496aad09686229fb59a2d0e75969e52/9.4.8/lib/aarch64-osx-ghc-9.4.8"
datadir    = "/Users/trikesh/Projects/fp_lab1/.stack-work/install/aarch64-osx/3c9cc461e16c32702af42fff8c7fbdc4f496aad09686229fb59a2d0e75969e52/9.4.8/share/aarch64-osx-ghc-9.4.8/euler-problems-1.0.0"
libexecdir = "/Users/trikesh/Projects/fp_lab1/.stack-work/install/aarch64-osx/3c9cc461e16c32702af42fff8c7fbdc4f496aad09686229fb59a2d0e75969e52/9.4.8/libexec/aarch64-osx-ghc-9.4.8/euler-problems-1.0.0"
sysconfdir = "/Users/trikesh/Projects/fp_lab1/.stack-work/install/aarch64-osx/3c9cc461e16c32702af42fff8c7fbdc4f496aad09686229fb59a2d0e75969e52/9.4.8/etc"

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
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
