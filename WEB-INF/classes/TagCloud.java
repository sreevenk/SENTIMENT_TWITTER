package Tag;
import processing.core.PApplet;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * Simple application wrapper to run the TagCloudGenerator from command line.
 * Please provide a config.properties for configuration.
 */
public class TagCloud {

    public static void main() {
        try {
            Configuration.getInstance().load(new FileInputStream("tagdata/config.properties"));
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
        PApplet.main(new String[]{"--present", "Tag.TagCloudGenerator"});
    }
}
