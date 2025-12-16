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

    function onKey(keyEvent as KeyEvent) as Boolean {
        if (keyEvent.getKey() == WatchUi.KEY_UP || keyEvent.getKey() == WatchUi.KEY_UP_LEFT || keyEvent.getKey() == WatchUi.KEY_UP_RIGHT) {
            app.controller.updateBpm(1);
            WatchUi.requestUpdate();
        }
        else if (keyEvent.getKey() == WatchUi.KEY_DOWN || keyEvent.getKey() == WatchUi.KEY_DOWN_LEFT || keyEvent.getKey() == WatchUi.KEY_DOWN_RIGHT) {
            app.controller.updateBpm(0);
            WatchUi.requestUpdate();
        }
        return true;
    }

    function onSwipe(swipeEvent as SwipeEvent) as Boolean {
        if (swipeEvent.getDirection() == WatchUi.SWIPE_UP) {
            return onMenu();
        }
        else if (swipeEvent.getDirection() == WatchUi.SWIPE_RIGHT) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        return true;
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }

    function onMenu() as Boolean {
        app.controller.stopMetronome();
        var menu = new WatchUi.Menu2(null);
        menu.setTitle(common.settingsTitle);
        menu.addItem(new WatchUi.MenuItem(common.beatsPerBar, app.controller.getBeatsPerBar(), :one, null));
        menu.addItem(new WatchUi.MenuItem(common.bpmAdd, app.controller.getBpmAdd(), :two, null));
        menu.addItem(new WatchUi.MenuItem(common.pulseLength, app.controller.getPulseLength(), :three, null));
        menu.addItem(new WatchUi.MenuItem(common.vibeStrength, app.controller.getVibeStrength(), :four, null));
        menu.addItem(new WatchUi.MenuItem(common.reset, null, :five, null));

        WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}