-- IMPORTS
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers --(isFullscreen, doFullFloat)
import XMonad.Hooks.DynamicProperty
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig 
import System.IO
import qualified XMonad.StackSet as W

import XMonad.Config()
import XMonad.Util.CustomKeys

-- Multimedia Audio
import Graphics.X11.ExtraTypes.XF86

--Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.GridVariants
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ZoomRow
import XMonad.Layout.SimplestFloat
import XMonad.Layout.OneBig

-- Layout modifiers
import qualified XMonad.Layout.ToggleLayouts as T
import XMonad.Layout.WindowArranger
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.LimitWindows
import XMonad.Layout.Renamed
import XMonad.Layout.Reflect
 
-- Actions
import XMonad.Actions.CopyWindow
import XMonad.Actions.Minimize
import XMonad.Actions.WindowBringer
import XMonad.Actions.WindowGo
import XMonad.Actions.WorkspaceNames
import XMonad.Actions.MouseResize

-- Data
import Data.List
import Control.Monad.Trans.Maybe
import Data.Maybe
import Data.Monoid

-- Hooks
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks, docksEventHook)

import Control.Monad
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import qualified Data.Map as M
import System.Directory
import System.FilePath.Posix
import qualified XMonad.Util.ExtensibleState as XS
import XMonad.Util.Minimize
import XMonad.Util.NamedActions


--------------------------------------------------------------------------
-----VARIABLES
--------------------------------------------------------------------------
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset


-- Selectors
spotifySelector = className =? "Spotify"

main = do
    xmproc <- spawnPipe "/home/dre/.xmonad/conkyscript"
    xmproc0 <- spawnPipe "/home/dre/.cabal/bin/xmobar -x 0 /home/dre/.config/xmobar/.xmobarrc"
    xmproc1 <- spawnPipe "/home/dre/.cabal/bin/xmobar -x 1 /home/dre/.config/xmobar/.xmobarrc1"
    xmonad 
        $ addDescrKeys ((myModMask, xK_F1), xMessage) myKeys
        $ defaultConfig
        
        { terminal          = myTerminal
        , modMask           = myModMask
        , borderWidth       = myBorderWidth
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor= myFocusBorderColor
        , handleEventHook   = myHandleEventHook
        , manageHook        = myManageHook <+> manageHook defaultConfig <+> manageDocks
        , layoutHook        = myLayoutHook -- <+> avoidStruts $ layoutHook defaultConfig
        , startupHook       = myStartupHook
        , workspaces        = myWorkspaces
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc0 x  >> hPutStrLn xmproc1 x
                        , ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#c3e88d" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#F07178" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#d0d0d0" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=#666666> | </fc>"                     -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }

        }

myTerminal              = "st"
myTextEditor            = "nvim"
myModMask               = mod4Mask -- Win key or Super_R
myBorderWidth           = 3
myNormalBorderColor     = "#292d3e"
myFocusBorderColor      = "#bbc5ff"

------------------------------------------------------------------------
---WORKSPACES
------------------------------------------------------------------------
-- My workspaces are clickable meaning that the mouse can be used to switch
-- workspaces. This requires xdotool.

--xmobarEscape = concatMap doubleLts
  --where
        --doubleLts '<' = "<<"
        --doubleLts x   = [x]

myWorkspaces            = ["1:main", "2:music", "3:tv", "4:work", "5", "6", "7", "8", "9"]
--myWorkspaces :: [String]
--myWorkspaces            = clickable . (map xmobarEscape)
                            -- $ ["1:main", "2:music", "3", "4", "5", "6", "7", "8", "9"]
    --where
        --clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                        --(i,ws) <- zip [1..9] l,
                        --let n = i ]


------------------------------------------------------------------------
-- LAYOUTS
------------------------------------------------------------------------
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $ 
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) $ myDefaultLayout
             where 
                 myDefaultLayout = tall ||| grid ||| threeCol ||| threeRow ||| oneBig ||| noBorders monocle ||| space ||| floats

tall     = renamed [Replace "tall"]     $ limitWindows 12 $ spacing 6 $ ResizableTall 1 (3/100) (1/2) []
grid     = renamed [Replace "grid"]     $ limitWindows 12 $ spacing 6 $ mkToggle (single MIRROR) $ Grid (16/10)
threeCol = renamed [Replace "threeCol"] $ limitWindows 3  $ ThreeCol 1 (3/100) (1/2) 
threeRow = renamed [Replace "threeRow"] $ limitWindows 3  $ Mirror $ mkToggle (single MIRROR) zoomRow
oneBig   = renamed [Replace "oneBig"]   $ limitWindows 6  $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (5/9) (8/12)
monocle  = renamed [Replace "monocle"]  $ limitWindows 20 $ Full
space    = renamed [Replace "space"]    $ limitWindows 4  $ spacing 12 $ Mirror $ mkToggle (single MIRROR) $ mkToggle (single REFLECTX) $ mkToggle (single REFLECTY) $ OneBig (2/3) (2/3)
floats   = renamed [Replace "floats"]   $ limitWindows 20 $ simplestFloat





------------------------------------------------------------------------
---- MANAGEHOOK
--------------------------------------------------------------------------
---- Sets some rules for certain programs. Examples include forcing certain
---- programs to always float, or to always appear on a certain workspace.
---- Forcing programs to a certain workspace with a doShift requires xdotool
---- if you are using clickable workspaces. You need the className or title 
---- of the program. Use xprop to get this info.

--myManageHook :: Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll  . concat $
    [
        [title =? "Oracle VM VirtualBox Manager" --> doFloat]
        ,[className =? "Gimp" --> doFloat]
        ,[className =? "arandr" --> doFloat]
    ]

--------------------------------------------------------------------------
---- EventHook
--------------------------------------------------------------------------
myHandleEventHook = docksEventHook
                <+> dynamicTitle myDynHook
                <+> handleEventHook def
    where
        myDynHook = composeAll
            [
                (className =? "" --> doShift "2:music") -- This is most likely spotify 
            ]

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
--
-- * NOTE: EwmhDesktops users should use the 'ewmh' function from
-- XMonad.Hooks.EwmhDesktops to modify their defaultConfig as a whole.
-- It will add initialization of EWMH support to your custom startup
-- hook by combining it with ewmhDesktopsStartup.

myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"
    spawnOnce "dunst &"
    spawnOnce "xrandr --output HDMI-1 --off --output DP-1 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output DP-2 --mode 1920x1080 --pos 3840x447 --rotate normal --output DP-3 --off"


isHangoutsTitle = isPrefixOf "Google Hangouts"

chromeSelectorBase = className =? "Google-chrome"
chromeSelector = chromeSelectorBase <&&>
                 fmap (not . isHangoutsTitle) title
hangoutsSelector = chromeSelectorBase <&&>
                   fmap isHangoutsTitle title
transmissionSelector = fmap (isPrefixOf "Transmission") title

virtualClasses = [ (hangoutsSelector, "Hangouts")
                 , (chromeSelector, "Chrome")
                 , (transmissionSelector, "Transmission")
                 ]

getClassRemap = do
  home <- getHomeDirectory
  -- TODO: handle the case where this file does not exist
  text <- B.readFile $ home </> ".lib/resources/window_class_to_fontawesome.json"
  return $ fromMaybe M.empty (decode text)

remapNames namedWindows = do
  remap <- io getClassRemap
  return $ map (\orig -> M.findWithDefault orig orig remap) namedWindows


classIfMatches window entry = do
  result <- runQuery (fst entry) window
  return $ if result then Just $ snd entry else Nothing

findM :: (Monad m) => (a -> m (Maybe b)) -> [a] -> m (Maybe b)
findM f = runMaybeT . msum . map (MaybeT . f)

getClass w = do
  virtualClass <- findM (classIfMatches w) virtualClasses
  case virtualClass of
    Nothing -> do
               classHint <- withDisplay $ \d -> io $ getClassHint d w
               return $ resClass classHint
    Just name -> return name

setWorkspaceNameToFocusedWindow workspace  = do
  namedWindows <- mapM getClass $ W.integrate' $ W.stack workspace
  renamedWindows <- remapNames namedWindows
  getWSName <- getWorkspaceNames'
  let newName = intercalate "|" renamedWindows
      currentName = fromMaybe "" (getWSName (W.tag workspace))
  when (currentName /= newName) $ setWorkspaceName (W.tag workspace) newName



-- Window switching

-- Use greedyView to switch to the correct workspace, and then focus on the
-- appropriate window within that workspace.
greedyFocusWindow w ws = W.focusWindow w $ W.greedyView
                         (fromMaybe (W.currentTag ws) $ W.findTag w ws) ws

-- Minimize not in class

restoreFocus action = withFocused $ \orig -> action >> windows (W.focusWindow orig)

windowIsMinimized w = do
  minimized <- XS.gets minimizedStack
  return $ w `elem` minimized

maybeUnminimize w = windowIsMinimized w >>= flip when (maximizeWindow w)

maybeUnminimizeFocused = withFocused maybeUnminimize

maybeUnminimizeAfter = (>> maybeUnminimizeFocused)

maybeUnminimizeClassAfter = (>> maximizeSameClassesInWorkspace)

getCurrentWS = W.stack . W.workspace . W.current

withWorkspace f = withWindowSet $ \ws ->
  maybe (return ()) f (getCurrentWS ws)

-- Type annotation is needed to resolve ambiguity
actOnWindowsInWorkspace :: (Window -> X ()) -> (W.Stack Window -> X [Window]) -> X ()
actOnWindowsInWorkspace windowAction getWindowsAction = restoreFocus $
  withWorkspace (getWindowsAction >=> mapM_ windowAction)

maximizeSameClassesInWorkspace =
  actOnWindowsInWorkspace maybeUnminimize windowsWithFocusedClass


windowsWithUnfocusedClass ws = windowsWithOtherClasses (W.focus ws) ws
windowsWithFocusedClass ws = windowsWithSameClass (W.focus ws) ws
windowsWithOtherClasses = windowsMatchingPredicate (/=)
windowsWithSameClass = windowsMatchingPredicate (==)

windowsMatchingPredicate predicate window workspace =
  windowsSatisfyingPredicate workspace $ do
    windowClass <- getClass window
    return $ predicate windowClass

windowsSatisfyingPredicate workspace getPredicate = do
  predicate <- getPredicate
  filterM (\w -> predicate <$> getClass w) (W.integrate workspace)

-- Raise or spawn

myRaiseNextMaybe = (maybeUnminimizeClassAfter .) . raiseNextMaybeCustomFocus greedyFocusWindow
myBringNextMaybe = (maybeUnminimizeAfter .) . raiseNextMaybeCustomFocus bringWindow

bindBringAndRaise :: KeyMask -> KeySym -> X () -> Query Bool -> [((KeyMask, KeySym), X ())]
bindBringAndRaise mask sym start query =
    [ ((mask, sym), myRaiseNextMaybe start query)
    , ((mask .|. controlMask, sym), myBringNextMaybe start query)]
bindBringAndRaiseMany :: [(KeyMask, KeySym, X (), Query Bool)] -> [((KeyMask, KeySym), X())]
bindBringAndRaiseMany = concatMap (\(a, b, c, d) -> bindBringAndRaise a b c d)

------------------------------------------------------------------------}}}
-- Bindings                                                             {{{
---------------------------------------------------------------------------
showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
    h <- spawnPipe "zenity" -- text-info --font=terminus"
    hPutStr h (unlines $ showKm x)
    hClose h
    return ()


myKeys conf = let
    subKeys str ks = subtitle str : mkNamedKeymap conf ks
    in
------------------------------------------------------------------------
-- Multimedia keys
------------------------------------------------------------------------
    subKeys "Multimedia"
    [
        ("<XF86AudioLowerVolume>", addName "Lower Volume" $ spawn "~/bin/liskin-media volume down") -- volume down
        ,("<XF86AudioMute>", addName "Mute Volume" $ spawn "~/bin/liskin-media mute")
        ,("<XF86AudioRaiseVolume>", addName "Raise Volume" $ spawn "~/bin/liskin-media volume up") -- volume up
        ,("<XF86AudioPlay>", addName "Play" $ spawn "~/bin/liskin-media play")
        ,("<XF86AudioPrev>", addName "Previons Track" $ spawn "~/bin/liskin-media prev")
        ,("<XF86AudioNext>", addName "Next Track" $ spawn "~/bin/liskin-media next")
    ] ^++^
--------------------------------------------------------------------------
-- Spawn Apps
--------------------------------------------------------------------------
    subKeys "Spawn Apps"
    [
        ("M-g", addName "Spawn google" $ spawn "/bin/google-chrome-stable")
        ,("M-s", addName "Spawn spotify" $ spawn "/bin/spotify")
        ,("M-M1-s", addName "Spawn spotify" $ spawn "/bin/spotify")
        ,("M-f", addName "Select emoji" $ spawn "~/.local/bin/dmenuunicode")
    ] ^++^
--------------------------------------------------------------------------
-- Windows
--------------------------------------------------------------------------
    subKeys "Windows"
    [
        ("M-d"                , addName "Duplicate w to all ws"       $ toggleCopyToAll)
    ]
        where
            toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
                                                   [] -> windows copyToAll
                                                   _ -> killAllOtherCopies

shiftThenView i = W.greedyView i . W.shift i
