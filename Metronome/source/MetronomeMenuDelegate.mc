import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MetronomeMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) { // vibe strength
            
        } 
        else if (item == :item_2) { // pulse length

        }
        else if (item == :item_3) { // reset settings

        }
    }

}