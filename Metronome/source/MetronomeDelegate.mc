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
        //view.updateBpmLabel();
        return true;
    }

    function onMinusBtn() as Boolean {
        app.controller.updateBpm(0);
        //view.updateBpmLabel();
        return true;
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new MetronomeMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}