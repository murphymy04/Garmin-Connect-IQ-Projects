import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeDelegate extends WatchUi.BehaviorDelegate {

    var app;
    const common = new $.MetronomeAppCommon();

    function initialize() {
        BehaviorDelegate.initialize();
        app = getApp();
    }

    function onPlusBtn() as Boolean {
        app.controller.updateBpm(1);
        return true;
    }

    function onMinusBtn() as Boolean {
        app.controller.updateBpm(0);
        return true;
    }

    function onSwipe(swipeEvent as SwipeEvent) as Boolean {
        if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            return onMenu();
        }
        return true;
    }

    function onMenu() as Boolean {
        app.controller.stopMetronome();
        var menu = new WatchUi.Menu2(null);
        menu.setTitle(common.settingsTitle);
        menu.addItem(new WatchUi.MenuItem(common.vibeStrength, app.controller.getVibeStrength(), :one, null));
        menu.addItem(new WatchUi.MenuItem(common.pulseLength, app.controller.getPulseLength(), :two, null));
        menu.addItem(new WatchUi.MenuItem(common.reset, null, :three, null));
        WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}