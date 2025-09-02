import Toybox.Graphics;
import Toybox.WatchUi;

class MetronomeView extends WatchUi.View {

    var app;

    function initialize() {
        View.initialize();
        app = getApp();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        app.controller.startMetronome();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        updateBpmLabel();
        View.onUpdate(dc);
        var centerX = dc.getWidth() / 2;
        var bottomY = dc.getHeight() - 15; 

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        // Arrow pointing down
        var arrow = [
            [centerX - 15, bottomY - 15],
            [centerX + 15, bottomY - 15],
            [centerX,      bottomY]
        ];

        dc.fillPolygon(arrow);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    private function updateBpmLabel() {
        var label = findDrawableById("bpmLabel") as WatchUi.Text;
        if (label != null) {
            label.setText("BPM: " + app.controller.getBpm());
        }
    }

}
