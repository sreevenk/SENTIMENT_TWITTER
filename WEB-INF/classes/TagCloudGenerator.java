
package Tag;
import processing.core.*;
import wordcram.WordCram;

import java.awt.*;

import wordcram.*;

public class TagCloudGenerator extends PApplet {

    private WordCram cram;

    public static Color FOREGROUND_COLOR = Color.black;

    public void setup() {
        Configuration config = Configuration.getInstance();
        size(config.getWidth(), config.getHeight());
        background(ColorHelper.decodeHex(config.getBackgroundColor()));

        TagCloudPlacer placer = TagCloudPlacer.fromFile(config.getShapeFile(), FOREGROUND_COLOR, false);
        WordsReader input = new WordsReader(config.getInputFile());
        Word[] words = input.getWords();
        TagCloudColorer colorer = new TagCloudColorer(config.getColors());
        TagCloudSizer sizer = new TagCloudSizer(config.getMinSize(), config.getMaxSize(), words);

        cram = new WordCram(this)
                .fromWords(words)
                .withColorer(colorer)
                .withPlacer(placer)
                .withNudger(placer)
                .withSizer(sizer);
    }

    /**
     * Called repeatedly by the main processing application. As only one render run is needed
     * to generate the image, this function saves the generated image and
     * exists after the first frame.
     */
    public void draw() {
        cram.drawAll();

        if (Configuration.getInstance().isDebug()) {
            printDebug();
        }

        save(Configuration.getInstance().getOutputFile());
        exit();
    }

    private void printDebug() {
        int skippedBecauseOfNoSpace  = 0;
        int skippedBecauseOfTooSmall = 0;
        Word[] skippedWords = cram.getSkippedWords();
        Word[] placedWords  = cram.getWords();
        for (Word skipped : skippedWords) {
            if (skipped.wasSkippedBecause() == WordCram.NO_SPACE) {
                skippedBecauseOfNoSpace++;
            } else if (skipped.wasSkippedBecause() == WordCram.SHAPE_WAS_TOO_SMALL) {
                skippedBecauseOfTooSmall++;
            }
        }
        System.out.println("- STATISTICS ---------------------------------------");
        System.out.println("Total placed Words:      " + placedWords.length);
        System.out.println("Total skipped Words:     " + skippedWords.length);
        System.out.println("-> because of no space:  " + skippedBecauseOfNoSpace);
        System.out.println("-> because of too small: " + skippedBecauseOfTooSmall);
        System.out.println("----------------------------------------------------");

    }
}
