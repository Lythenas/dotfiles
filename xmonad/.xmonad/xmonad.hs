module Main (main) where

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Prompt.AppLauncher
import XMonad.Prompt.XMonad
import XMonad.Layout.NoBorders
import Graphics.X11.ExtraTypes.XF86
import System.IO
import Data.Maybe (maybeToList)
import Control.Monad (when, join)

main = do
  xmproc <- spawnPipe "~/.cabal/bin/xmobar"
  xmonad $ ewmh $ docks defaultConfig
      { terminal    = "alacritty"
      , modMask     = superMask
      , borderWidth = 3
      , manageHook  = manageDocks <+> myManageHook <+> manageHook defaultConfig
      , handleEventHook = fullscreenEventHook
      , startupHook = addEWMHFullscreen
      , layoutHook  = myLayout
      , logHook = dynamicLogWithPP xmobarPP
                      { ppOutput = hPutStrLn xmproc
                      , ppTitle  = xmobarColor "green" "" . shorten 50
                      }
      } `additionalKeys` myAdditionalKeys

superMask = mod4Mask

myManageHook = composeAll
    [ className =? "Gimp" --> doFloat ]

-- Layout:
--   -- Tall (with statusbar and borders)
--   -- Mirror Tall (with statusbar and borders)
--   -- Full (no statusbar and no borders)
myLayout = smartBorders $ avoidStruts (tiled ||| Mirror tiled) ||| noBorders Full
    where
        tiled = Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 3/100

-- EWMH support for fullscreen (e.g. for youtube videos)
addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

-- Keyboard symbols docs: https://hackage.haskell.org/package/X11-1.9/docs/Graphics-X11-Types.html#g:2
--        and media keys: https://hackage.haskell.org/package/X11-1.9/docs/Graphics-X11-ExtraTypes-XF86.html
-- Format: ((modifiers, key), action)
myAdditionalKeys = 
    [ ((superMask .|. shiftMask, xK_z), spawn lockCommand)
    , ((controlMask, xK_Print), spawn screenshotInteractiveCommand)
    , ((0, xK_Print), spawn screenshotCommand)
    , ((superMask, xK_p), spawn "dmenu-launch")
    -- changing the reload shortcut because xmessage is not working corretly on my system
    , ((superMask, xK_q), spawn "if type xmonad; then (xmonad --recompile || notify-send \"Error in xmonad.hs\") && xmonad --restart; else notify-send xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
    , ((superMask .|. shiftMask, xK_q), return ())

    -- Media Keys
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")
    , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
    , ((0, xF86XK_AudioMicMute), spawn "amixer set Capture toggle")
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +5")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -5")
    , ((0, xF86XK_Display), spawn "~/bin/displayselect")
    --, ((0, xF86XK_WLAN), spawn "notify-send WLAN") -- bound in hardware (on my laptop)
    , ((0, xF86XK_Tools), spawn "notify-send Tools")
    , ((0, xF86XK_Search), spawn "notify-send Search")
    , ((0, xF86XK_LaunchA), spawn "notify-send LaunchA")
    , ((0, xF86XK_Explorer), spawn "notify-send Explorer")

    , ((superMask, xK_F12), xmonadPrompt def)
    ]

lockCommand = "xscreensaver-command -lock"
screenshotInteractiveCommand = "sleep 0.2; scrot -s" -- lets you select the region to screenshot
screenshotCommand = "scrot"
