import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeApp extends Application.AppBase {

    var bpm = 60;
    var interval = 1000;
    var beatTimer;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new MetronomeView(), new MetronomeDelegate() ];
    }

    private function updateInterval() {
        interval = (60000.0 / bpm).toNumber();
    }

}

function getApp() as MetronomeApp {
    return Application.getApp() as MetronomeApp;
}