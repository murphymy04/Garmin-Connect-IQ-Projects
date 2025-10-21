import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class MetronomeController {
    hidden var bpm;
    hidden var vibeStrength;
    hidden var pulseLength;
    hidden var beatTimer;
    hidden var backlightTimer;
    hidden var interval = 1000; // ms
    hidden var bpmAdd;
    const common = new $.MetronomeAppCommon();

    function initialize() {
        var bpmStore = Storage.getValue("bpm");
        var vibeStrengthStore = Storage.getValue("vibeStrength");
        var pulseLengthStore = Storage.getValue("pulseLength");
        var bpmAddStore = Storage.getValue("bpmAdd");

        bpm = (bpmStore == null) ? common.defaultBpm : bpmStore;
        vibeStrength = (vibeStrengthStore == null) ? common.defaultVibeStrength : vibeStrengthStore;
        pulseLength = (pulseLengthStore == null) ? common.defaultPulseLength : pulseLengthStore;
        bpmAdd = (bpmAddStore == null) ? common.defaultBpmAdd : bpmAddStore;
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
        startBacklightTimer();
    }

    function stopMetronome() {
        if (beatTimer != null) {
            beatTimer.stop();
            beatTimer = null;
        }
        stopBacklightTimer();
    }

    function turnOffBacklight() as Void {
        Attention.backlight(false);
    }

    function startBacklightTimer() {
        if (backlightTimer != null) {
            backlightTimer.stop();
        }

        backlightTimer = new Timer.Timer();
        backlightTimer.start(method(:turnOffBacklight), common.screenBacklightTimeout, true);
    }

    function stopBacklightTimer() {
        if (backlightTimer != null) {
            backlightTimer.stop();
            backlightTimer = null;
        }
    }

    function updateBpm(add as Boolean) {
        if (add) {
            if (bpm <= 245) { // upper bound
                bpm += bpmAdd;
            }
        }
        else {
            if (bpm >= 35) { // lower bound
                bpm -= bpmAdd;
            }
        }
        startMetronome();
    }

    function getBpm() as String {
        return bpm.toString();
    }

    function getVibeStrength() as String {
        return vibeStrength.toString() + "%";
    }

    function getPulseLength() as String {
        return pulseLength.toString() + " ms";
    }

    function getBpmAdd() as String {
        return bpmAdd.toString() + " bpm";
    }

    function saveBpm() {
        Storage.setValue("bpm", bpm);
    }

    function saveVibeStrength(newVibeStrength) {
        vibeStrength = newVibeStrength;
        Storage.setValue("vibeStrength", vibeStrength);
    }

    function savePulseLength(newPulseLength) {
        pulseLength = newPulseLength;
        Storage.setValue("pulseLength", pulseLength);
    }

    function saveBpmAdd(newBpmAdd) {
        bpmAdd = newBpmAdd;
        Storage.setValue("bpmAdd", bpmAdd);
    }

    function resetSettings() {
        bpm = common.defaultBpm;
        saveBpm();
        saveVibeStrength(common.defaultVibeStrength);
        savePulseLength(common.defaultPulseLength);
        saveBpmAdd(common.defaultBpmAdd);
    }

    private function updateInterval() {
        interval = (60000.0 / bpm).toNumber();
    }
}