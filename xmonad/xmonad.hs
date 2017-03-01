-- ~/.xmonad/xmonad.hs - full xmonad configuration

import XMonad
import qualified XMonad.Config as DefConfig (def)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout
import XMonad.Layout.NoBorders ( noBorders, smartBorders )
import XMonad.Hooks.SetWMName
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ DefConfig.def
      { terminal           = "urxvt"
      , focusFollowsMouse  = True
      , clickJustFocuses   = False
      , borderWidth        = 1
      , modMask            = mod4Mask
      , workspaces         = myworkspaces
      , normalBorderColor  = "#dddddd"
      , focusedBorderColor = "#00dd00"
      , manageHook         = manageDocks <+> myManagers
                                         <+> manageHook DefConfig.def
      , layoutHook         = avoidStruts
                           $ smartBorders
                           $ layoutHook DefConfig.def
      --, layoutHook         = avoidStruts  $  layoutHook DefConfig.def
      -- this must be done in this order, docksEventHook must be last
      , handleEventHook    = handleEventHook DefConfig.def <+> docksEventHook
      , logHook            = dynamicLogWithPP xmobarPP
          { ppOutput          = hPutStrLn xmproc
          , ppTitle           = xmobarColor "lime"  "" . shorten 20
          , ppCurrent         = xmobarColor "aquamarine" "" . wrap "[" "]"
          , ppHiddenNoWindows = xmobarColor "slateblue" ""
          , ppLayout          = shorten 6
          , ppVisible         = wrap "(" ")"
          , ppUrgent          = xmobarColor "fuchsia" "gold"
          }
      , startupHook        = setWMName "LG3D"
      } `additionalKeys`
      [ ((mod4Mask .|. shiftMask, xK_z) , spawn screenLock)
      , ((controlMask, xK_q)            , spawn gVim)
      , ((controlMask, xK_Print)        , spawn scrotWindow)
      , ((0, xK_Print)                  , spawn scrotFullscreen)
      , ((mod4Mask, xK_p)               , spawn myDmenu)
      , ((mod4Mask, xK_b)               , sendMessage ToggleStruts)
      ]

scrotWindow     = "sleep 1; scrot -s ~/%Y-%m-%s-%T-screenshot.png"
scrotFullscreen = "scrot ~/%Y-%m-%d-%T-screenshot.png"
screenLock      = "xscreensaver-command -lock"
gVim            = "gvim"
-- change the Xmonad default font for dmenu
myDmenu         = "dmenu_run -fn Dina:size=9"

myworkspaces = [ "code"
               , "web"
               , "media"
               , "irc"
               , "random"
               , "mail"
               , "docs"
               , "music"
               , "root"
               ]

myManagers = composeAll
    [ className =? "Gimp" --> doShift "random"
    , className =? "Firefox"  --> doShift "web"
    , (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
    ]

