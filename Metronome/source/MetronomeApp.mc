import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeApp extends Application.AppBase {

    const controller = new $.MetronomeController();

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        controller.startMetronome();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        controller.stopMetronome();
        controller.saveBpm();
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new MetronomeView(), new MetronomeDelegate() ];
    }
}

function getApp() as MetronomeApp {
    return Application.getApp() as MetronomeApp;
}