module Main (main) where

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.DynamicBars
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.NamedActions
import XMonad.Prompt.AppLauncher
import XMonad.Prompt.XMonad
import XMonad.Prompt.ConfirmPrompt
import XMonad.Layout.NoBorders
import XMonad.Layout.Maximize
import XMonad.Actions.Commands
import XMonad.Actions.FloatKeys
import qualified XMonad.StackSet as W
import Graphics.X11.ExtraTypes.XF86
import System.IO
import System.Exit
import Data.Maybe (maybeToList)
import Data.Ratio ((%))
import Data.List
import Control.Monad (when, join)

main = do
  --xmproc <- spawnPipe "~/.cabal/bin/xmobar"
  xmonad $ ewmh $ docks
      $ addDescrKeys ((superMask, xK_F1), xMessage) myKeyMap def
          { terminal    = "alacritty"
          , modMask     = superMask
          , borderWidth = 3
          , manageHook  = myManageHook <+> manageHook def
          , handleEventHook = addDynamicStatusBarEH >> fullscreenEventHook
          , startupHook = myStartupHook
          , layoutHook  = myLayout
          , logHook = multiPP myXmobarPPfocused myXmobarPPnotFocused
          }

myXmobarPPfocused = xmobarPP { ppTitle  = xmobarColor "green" "" . shorten 100 }
myXmobarPPnotFocused = myXmobarPPfocused { ppCurrent = wrap "[" "]" }

superMask = mod4Mask
altMask = mod1Mask

myStartupHook = do
  spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype request --transparent true --tint 0x191970 --height 17 --monitor primary"
  spawn "feh --bg-scale ~/dotfiles/wallpaper/wallpaper.png"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "thunderbird"
  addDynamicStatusBar >> addEWMHFullscreen

myManageHook = composeAll
    [ className =? "Thunderbird" --> doF (W.shift "9")
    , className =? "Gxmessage" --> doFloat
    , className =? "Xmessage" --> doFloat
    , className =? "Firefox" <&&> resource =? "Dialog" --> doFloat
    -- Float gimp toolboxes but not main window
    , role =? "gimp-toolbox-1" --> doFloat
    , role =? "gimp-dock-1" --> doFloat
    ]
    where
        role = stringProperty "WM_WINDOW_ROLE"

-- Layout:
--   -- Tall (with statusbar and borders)
--   -- Mirror Tall (with statusbar and borders)
--   -- Full (no statusbar and no borders)
myLayout = maximizeWithPadding 0
    $ smartBorders
    $ avoidStruts (tiled ||| Mirror tiled) ||| Tall 0 (3/100) (1/2) ||| noBorders Full
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

-- Setup dynamic status bars
addDynamicStatusBar = dynStatusBarStartup dynStatusBar dynStatusBarCleanup

addDynamicStatusBarEH = dynStatusBarEventHook dynStatusBar dynStatusBarCleanup

dynStatusBar :: DynamicStatusBar
dynStatusBar (S screenId) = spawnPipe $ "~/.local/bin/xmobar --screen=" ++ show screenId

dynStatusBarCleanup :: DynamicStatusBarCleanup
dynStatusBarCleanup = return ()

-- Keyboard symbols docs: https://hackage.haskell.org/package/X11-1.9/docs/Graphics-X11-Types.html#g:2
--        and media keys: https://hackage.haskell.org/package/X11-1.9/docs/Graphics-X11-ExtraTypes-XF86.html
-- Format: ((modifiers, key), action)
myKeyMap :: XConfig a -> [((KeyMask, KeySym), NamedAction)]
myKeyMap = const
    [ subtitle "main"
    , ((superMask .|. shiftMask, xK_z), addName "lock" $ spawn lockCommand)
    , ((controlMask, xK_Print), addName "screenshot (interactive)" $ spawn screenshotInteractiveCommand)
    , ((0, xK_Print), addName "screenshot" $ spawn screenshotCommand)
    , ((superMask, xK_p), addName "launcher" $ spawn "dmenu-launch")
    , ((superMask .|. shiftMask, xK_p), addName "commands" $ commands >>= runCommand)
    , ((superMask .|. shiftMask, xK_q), addName "quit wm" quitWm)
    , ((superMask, xK_f), addName "maximized window" $ withFocused (sendMessage . maximizeRestore))
    , ((superMask, xK_b), addName "toggle status bar" $ sendMessage ToggleStruts)

    -- Media Keys
    , subtitle "media keys"
    , ((0, xF86XK_AudioLowerVolume), addName "lower volume" $ spawn "amixer set Master 5%-")
    , ((shiftMask, xF86XK_AudioLowerVolume), addName "lower volume" $ spawn "amixer set Master 1%-")
    , ((0, xF86XK_AudioRaiseVolume), addName "raise volume" $ spawn "amixer set Master 5%+")
    , ((shiftMask, xF86XK_AudioRaiseVolume), addName "raise volume" $ spawn "amixer set Master 1%+")
    , ((0, xF86XK_AudioMute), addName "mute volume" $ spawn "amixer set Master toggle")
    , ((0, xF86XK_AudioMicMute), addName "mute mic" $ spawn "amixer set Capture toggle")
    , separator
    , ((0, xF86XK_MonBrightnessUp), addName "lower brightness" $ spawn "xbacklight +5")
    , ((shiftMask, xF86XK_MonBrightnessUp), addName "lower brightness" $ spawn "xbacklight +1")
    , ((0, xF86XK_MonBrightnessDown), addName "raise brightness" $ spawn "xbacklight -5")
    , ((shiftMask, xF86XK_MonBrightnessDown), addName "raise brightness" $ spawn "xbacklight -1")
    , ((0, xF86XK_Display), addName "configure display" $ spawn "~/bin/displayselect")
    -- , ((0, xF86XK_WLAN), spawn "notify-send WLAN") -- bound in hardware (on my laptop)
    , separator
    , ((0, xF86XK_Tools), noName $ spawn "notify-send Tools")
    , ((0, xF86XK_Search), noName $ spawn "notify-send Search")
    , ((0, xF86XK_LaunchA), noName $ spawn "notify-send LaunchA")
    , ((0, xF86XK_Explorer), noName $ spawn "notify-send Explorer")

    -- FloatKeys
    , subtitle "modify floating windows"
    , ((superMask .|. altMask, xK_h), addName "move left" $ withFocused $ keysMoveWindow (-10, 0))
    , ((superMask .|. altMask, xK_j), addName "move down" $ withFocused $ keysMoveWindow (0, 10))
    , ((superMask .|. altMask, xK_k), addName "move up" $ withFocused $ keysMoveWindow (0, -10))
    , ((superMask .|. altMask, xK_l), addName "move right" $ withFocused $ keysMoveWindow (10, 0))
    , ((superMask .|. altMask, xK_plus), addName "expand" $ withFocused $ keysResizeWindow (10, 10) (1%2, 1%2))
    , ((superMask .|. altMask, xK_minus), addName "shrink" $ withFocused $ keysResizeWindow (-10, -10) (1%2, 1%2))

    -- Misc
    , subtitle "misc"
    , ((superMask, xK_Delete), addName "toggle notification center" $ spawn "kill -s USR1 $(pidof deadd-notification-center)")
    , ((superMask, xK_F1), addName "show help" $ showHelp)
    ]

commands :: X [(String, X ())]
commands = return 
    [ ("quit-wm", quitWm)
    , ("restart-wm", restart "xmonad" True)
    ]

quitWm :: X ()
quitWm = confirmPrompt def "Quit Xmonad?" $ io $ exitWith ExitSuccess

lockCommand = "xscreensaver-command -lock"
screenshotInteractiveCommand = "sleep 0.2; scrot -s" -- lets you select the region to screenshot
screenshotCommand = "scrot"

showHelp = spawn $
    "echo -e " ++
    show help ++
    " | gxmessage -center -borderless -ontop -wrap" ++
    " -geometry 1600x800" ++
    " -fn \"Hasklug Nerd Font 14\" -file -"

help :: String
help = unlines ["The modifier key is 'super'. Keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    --"mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "",
    "-- Workspaces & screens",
    "mod-[1..9]         Switch to workSpace N",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
