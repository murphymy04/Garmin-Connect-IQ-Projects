import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new MetronomeMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}