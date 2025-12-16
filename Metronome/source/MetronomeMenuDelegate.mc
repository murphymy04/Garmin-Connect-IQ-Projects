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
        var itemId = item.getId();
        if (itemId == :one) { // beats per bar
            var menu = new WatchUi.Menu2(null);
            menu.setTitle(common.beatsPerBar);
            for (var i=1; i<=16; i++) {
                menu.addItem(new WatchUi.MenuItem(i.toString(), null, :beatsPerBar, null));
            }
            WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_LEFT);
        } 
        else if (itemId == :two) { // bpm add
            var menu = new WatchUi.Menu2(null);
            menu.setTitle(common.bpmAdd);
            menu.addItem(new WatchUi.MenuItem("1 bpm", null, :bpmOne, null));
            menu.addItem(new WatchUi.MenuItem("5 bpm", null, :bpmTwo, null));
            WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_LEFT);
        }
        else if (itemId == :three) { // pulse length
            var menu = new WatchUi.Menu2(null);
            menu.setTitle(common.pulseLength);
            menu.addItem(new WatchUi.MenuItem("50 ms", null, :pulseOne, null));
            menu.addItem(new WatchUi.MenuItem("80 ms", null, :pulseTwo, null));
            menu.addItem(new WatchUi.MenuItem("100 ms", null, :pulseThree, null));
            WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_LEFT);
        }
        else if (itemId == :four) { // vibe strength
            var menu = new WatchUi.Menu2(null);
            menu.setTitle(common.vibeStrength);
            menu.addItem(new WatchUi.MenuItem("60%", null, :vibeOne, null));
            menu.addItem(new WatchUi.MenuItem("75%", null, :vibeTwo, null));
            menu.addItem(new WatchUi.MenuItem("100%", null, :vibeThree, null));
            WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_LEFT);
        }
        else if (itemId == :five) { // reset settings
            app.controller.resetSettings();
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
        }
        else {
            if (itemId == :vibeOne) {
                app.controller.saveVibeStrength(60);
            }
            else if (itemId == :vibeTwo) {
                app.controller.saveVibeStrength(75);
            }
            else if (itemId == :vibeThree) {
                app.controller.saveVibeStrength(100);
            }
            else if (itemId == :pulseOne) {
                app.controller.savePulseLength(50);
            }
            else if (itemId == :pulseTwo) {
                app.controller.savePulseLength(80);
            }
            else if (itemId == :pulseThree) {
                app.controller.savePulseLength(100);
            }
            else if (itemId == :bpmOne) {
                app.controller.saveBpmAdd(1);
            }
            else if (itemId == :bpmTwo) {
                app.controller.saveBpmAdd(5);
            }
            else if (itemId == :beatsPerBar) {
                app.controller.saveBeatsPerBar(item.getLabel().toNumber());
            }
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            var menu = new WatchUi.Menu2(null);
            menu.setTitle(common.settingsTitle);
            menu.addItem(new WatchUi.MenuItem(common.beatsPerBar, app.controller.getBeatsPerBar(), :one, null));
            menu.addItem(new WatchUi.MenuItem(common.bpmAdd, app.controller.getBpmAdd(), :two, null));
            menu.addItem(new WatchUi.MenuItem(common.pulseLength, app.controller.getPulseLength(), :three, null));
            menu.addItem(new WatchUi.MenuItem(common.vibeStrength, app.controller.getVibeStrength(), :four, null));
            menu.addItem(new WatchUi.MenuItem(common.reset, null, :five, null));
            WatchUi.pushView(menu, new MetronomeSettingsMenuDelegate(), WatchUi.SLIDE_RIGHT);
        }  
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
