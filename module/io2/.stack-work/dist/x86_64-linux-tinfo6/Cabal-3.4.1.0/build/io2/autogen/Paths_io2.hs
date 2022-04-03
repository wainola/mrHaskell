{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_io2 (
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

bindir     = "/home/nrriquel/Documents/haskell/haskell/module/io2/.stack-work/install/x86_64-linux-tinfo6/7a1620c779c76e802c43d263bb3675b41fc07a08a818f1bb49b0275b8a0e38cb/9.0.2/bin"
libdir     = "/home/nrriquel/Documents/haskell/haskell/module/io2/.stack-work/install/x86_64-linux-tinfo6/7a1620c779c76e802c43d263bb3675b41fc07a08a818f1bb49b0275b8a0e38cb/9.0.2/lib/x86_64-linux-ghc-9.0.2/io2-0.1.0.0-32EurFhLFOyKQTO6H1oRXN-io2"
dynlibdir  = "/home/nrriquel/Documents/haskell/haskell/module/io2/.stack-work/install/x86_64-linux-tinfo6/7a1620c779c76e802c43d263bb3675b41fc07a08a818f1bb49b0275b8a0e38cb/9.0.2/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/home/nrriquel/Documents/haskell/haskell/module/io2/.stack-work/install/x86_64-linux-tinfo6/7a1620c779c76e802c43d263bb3675b41fc07a08a818f1bb49b0275b8a0e38cb/9.0.2/share/x86_64-linux-ghc-9.0.2/io2-0.1.0.0"
libexecdir = "/home/nrriquel/Documents/haskell/haskell/module/io2/.stack-work/install/x86_64-linux-tinfo6/7a1620c779c76e802c43d263bb3675b41fc07a08a818f1bb49b0275b8a0e38cb/9.0.2/libexec/x86_64-linux-ghc-9.0.2/io2-0.1.0.0"
sysconfdir = "/home/nrriquel/Documents/haskell/haskell/module/io2/.stack-work/install/x86_64-linux-tinfo6/7a1620c779c76e802c43d263bb3675b41fc07a08a818f1bb49b0275b8a0e38cb/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "io2_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "io2_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "io2_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "io2_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "io2_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "io2_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
