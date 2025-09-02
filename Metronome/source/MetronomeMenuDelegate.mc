import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MetronomeSettingsMenuDelegate extends WatchUi.Menu2InputDelegate {

    const common = new MetronomeAppCommon();
    var app;

    function initialize() {
        Menu2InputDelegate.initialize();
        app = getApp();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        item = item.getId();
        if (item == :one) { // vibe strength
            var menu = new WatchUi.Menu2(null);
            menu.setTitle(common.vibeStrength);
            menu.addItem(new WatchUi.MenuItem("50%", null, :vibeOne, null));
            menu.addItem(new WatchUi.MenuItem("75%", null, :vibeTwo, null));
            menu.addItem(new WatchUi.MenuItem("100%", null, :vibeThree, null));
            WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_LEFT);
        } 
        else if (item == :two) { // pulse length
            var menu = new WatchUi.Menu2(null);
            menu.setTitle(common.pulseLength);
            menu.addItem(new WatchUi.MenuItem("50 ms", null, :pulseOne, null));
            menu.addItem(new WatchUi.MenuItem("80 ms", null, :pulseTwo, null));
            menu.addItem(new WatchUi.MenuItem("100 ms", null, :pulseThree, null));
            WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_LEFT);
        }
        else if (item == :three) { // reset settings
            app.controller.resetSettings();
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
        else {
            if (item == :vibeOne) {
                app.controller.saveVibeStrength(50);
            }
            else if (item == :vibeTwo) {
                app.controller.saveVibeStrength(75);
            }
            else if (item == :vibeThree) {
                app.controller.saveVibeStrength(100);
            }
            else if (item == :pulseOne) {
                app.controller.savePulseLength(50);
            }
            else if (item == :pulseTwo) {
                app.controller.savePulseLength(80);
            }
            else if (item == :pulseThree) {
                app.controller.savePulseLength(100);
            }
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            var menu = new WatchUi.Menu2(null);
            menu.setTitle(common.settingsTitle);
            menu.addItem(new WatchUi.MenuItem(common.vibeStrength, app.controller.getVibeStrength(), :one, null));
            menu.addItem(new WatchUi.MenuItem(common.pulseLength, app.controller.getPulseLength(), :two, null));
            menu.addItem(new WatchUi.MenuItem(common.reset, null, :three, null));
            WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_RIGHT);
        }  
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}