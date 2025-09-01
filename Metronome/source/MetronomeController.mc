import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeController {
    hidden var bpm = 60;
    hidden var interval = 1000; // ms
    hidden var vibeStrength = 100; // %
    hidden var pulseLength = 80; // ms
    hidden var beatTimer;

    function initialize() {
        var bpmStore = Storage.getValue("bpm");
        var intervalStore = Storage.getValue("interval");
        var vibeStrengthStore = Storage.getValue("vibeStrength");
        var pulseLengthStore = Storage.getValue("pulseLength");

        bpm = (bpmStore == null) ? bpm : bpmStore;
        interval = (intervalStore == null) ? interval : intervalStore;
        vibeStrength = (vibeStrengthStore == null) ? vibeStrength : vibeStrengthStore;
        pulseLength = (pulseLengthStore == null) ? pulseLength : pulseLengthStore;
    }

    function onBeat() as Void {
        var vibeData = [];
        if (Attention has :vibrate) {
            vibeData = [new Attention.VibeProfile(vibeStrength, pulseLength)];
        }
        Attention.vibrate(vibeData);
    }

    function startMetronome() {
        updateInterval();
        if (beatTimer != null) {
            beatTimer.stop();
        }

        beatTimer = new Timer.Timer();
        beatTimer.start(method(:onBeat), interval, true);
    }

    function stopMetronome() {
        if (beatTimer != null) {
            beatTimer.stop();
            beatTimer = null;
        }
    }

    function updateBpm(add as Boolean) {
        if (add) {
            if (bpm <= 245) { // upper bound
                bpm += 5;
            }
        }
        else {
            if (bpm >= 35) { // lower bound
                bpm -= 5;
            }
        }
        startMetronome();
    }

    function getBpm() as String {
        return bpm.toString();
    }

    function saveBpm() {
        Storage.setValue("bpm", bpm);
    }

    private function updateInterval() {
        interval = (60000.0 / bpm).toNumber();
    }
}