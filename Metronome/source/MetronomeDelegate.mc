import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeDelegate extends WatchUi.BehaviorDelegate {

    var app;
    var view;

    function initialize() {
        BehaviorDelegate.initialize();
        app = getApp();
        view = getCurrentView();
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
        var menu = new WatchUi.Menu();
        menu.setTitle("Metronome Settings");
        menu.addItem("Vibration Strength", :one);
        menu.addItem("Pulse Length", :two);
        menu.addItem("Reset Settings", :three);
        WatchUi.pushView(menu, new MetronomeMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}