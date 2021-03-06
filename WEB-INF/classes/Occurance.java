package CT;
import java.io.*;
import databaseconnection.*;
import java.util.*;
import java.sql.*;

public class Occurance {
public static void main(String file) throws Exception {         

////

PrintWriter pw=new PrintWriter("D:/Apache Software Foundation/Tomcat 8.0/tagdata/input.txt");

    LinkedHashMap<String, Integer> wordcount =
    new LinkedHashMap<String, Integer>();
    try { 


        BufferedReader in = new BufferedReader(
        new FileReader(file));
        String str;

        while ((str = in.readLine()) != null) { 
            str = str.toLowerCase(); // convert to lower case 
            String[] words = str.split("\\s+"); //split the line on whitespace, would return an array of words

            for( String word : words ) {
              if( word.length() < 4 ) {
                continue; 
              }
              Integer occurences = wordcount.get(word);
              if( occurences == null) {
                occurences = 1;
              } else {
                occurences++;
              }
              wordcount.put(word, occurences);
            }

               } 

    ArrayList<Integer> values = new ArrayList<Integer>();
    values.addAll(wordcount.values());

    Collections.sort(values, Collections.reverseOrder());

    int last_i = -1;

Connection con = databasecon.getconnection();
Statement st=con.createStatement();


    for (Integer i : values.subList(0,10)) { 
        if (last_i == i) // without duplicates
            continue;
        last_i = i;


           for (String s : wordcount.keySet()) { 
            if (wordcount.get(s) == i) // which have this value  
				{

				if(i>0){

				

				pw.println(s+","+i);
			System.out.println(s+","+i);
			
			

				}
				
				}


   }
    } 
	pw.close();
        } 
    catch(Exception e){
        //System.out.println(e);
    }


}
public static void main(String[] args) throws Exception
	{
		System.out.println("Hello World!");
		//main("E://Apache Tomcat//Tweets//33347pos");
	}

}