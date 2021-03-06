package CT;

import java.io.*;

import org.jfree.chart.ChartUtilities;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

public class PieChart {
   
   public static void main( String[ ] args ) throws Exception {
	main(10,20,30);
   }


public static void main(int pos, int neg, int nue) throws Exception {
      DefaultPieDataset dataset = new DefaultPieDataset( );
      dataset.setValue("Positive", new Double( pos ) );
      dataset.setValue("Negative", new Double( neg ) );
      dataset.setValue("Neutral", new Double( nue ) );

      JFreeChart chart = ChartFactory.createPieChart(
         "Sentiment Analysis",   // chart title
         dataset,          // data
         true,             // include legend
         true,
         false);
         
      int width = 640;   /* Width of the image */
      int height = 480;  /* Height of the image */ 
      File pieChart = new File( "D://Apache Software Foundation/Tomcat 8.0/webapps/Sentiment/PieChart.jpeg" ); 
      ChartUtilities.saveChartAsJPEG( pieChart , chart , width , height );
   }

}