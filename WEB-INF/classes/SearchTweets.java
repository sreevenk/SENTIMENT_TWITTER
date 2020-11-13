package CT;
import twitter4j.*;
import java.io.*;
import twitter4j.auth.OAuth2Token;
import databaseconnection.databasecon;
import twitter4j.conf.ConfigurationBuilder;

import java.util.Map;
import java.util.Vector;
import java.sql.*;

public class SearchTweets {
	

	private static PrintWriter pw=null;
	private static final String CONSUMER_KEY		= "3H8VEdM8tooU4iNgZbZNLoE1S";
	private static final String CONSUMER_SECRET 	= "MovNMWZWbj59F0SsP0IeNs2DKkQwlaca3VXi0o95VFVmoNsRcu";

	private static final int TWEETS_PER_QUERY		= 500;

	private static final int MAX_QUERIES			= 1;

	private static  String SEARCH_TERM			= "";

	public static String cleanText(String text)
	{
		text = text.replace("\n", "\\n");
		text = text.replace("\t", "\\t");
		return text;
	}


	public static OAuth2Token getOAuth2Token()
	{
		OAuth2Token token = null;
		ConfigurationBuilder cb;

		cb = new ConfigurationBuilder();
		cb.setApplicationOnlyAuthEnabled(true);

		cb.setOAuthConsumerKey(CONSUMER_KEY).setOAuthConsumerSecret(CONSUMER_SECRET);

		try
		{
			token = new TwitterFactory(cb.build()).getInstance().getOAuth2Token();
		}
		catch (Exception e)
		{
			System.out.println("Could not get OAuth2 token");
			e.printStackTrace();
			System.exit(0);
		}

		return token;
	}

	public static Twitter getTwitter()
	{
		OAuth2Token token;

		token = getOAuth2Token();

		ConfigurationBuilder cb = new ConfigurationBuilder();
		cb.setApplicationOnlyAuthEnabled(true);
		cb.setOAuthConsumerKey(CONSUMER_KEY);
		cb.setOAuthConsumerSecret(CONSUMER_SECRET);
		cb.setOAuth2TokenType(token.getTokenType());
		cb.setOAuth2AccessToken(token.getAccessToken());

		return new TwitterFactory(cb.build()).getInstance();

	}

	public static Vector<String> main(String args)throws Exception
	{
		Vector<String> v=new Vector<String>();


	Connection con=databasecon.getconnection();

	
	PreparedStatement ps=con.prepareStatement("delete from tweets");
//	ps.executeUpdate();
	 ps=con.prepareStatement("insert into tweets(sno,topic,user_,tweet,pos,neg,result) values(?,?,?,?,?,?,?)");

		SEARCH_TERM=args;
		int	totalTweets = 0;
		long maxID = -1;

		Twitter twitter = getTwitter();
		int count=1;
		try
		{
			Map<String, RateLimitStatus> rateLimitStatus = twitter.getRateLimitStatus("search");
			RateLimitStatus searchTweetsRateLimit = rateLimitStatus.get("/search/tweets");
			System.out.printf("You have %d calls remaining out of %d, Limit resets in %d seconds\n",
							  searchTweetsRateLimit.getRemaining(),
							  searchTweetsRateLimit.getLimit(),
							  searchTweetsRateLimit.getSecondsUntilReset());

			for (int queryNumber=0;queryNumber < MAX_QUERIES; queryNumber++)
			{
			
			//				pw=new PrintWriter("log"+queryNumber+".txt");
			
				System.out.printf("\n\n!!! Starting loop %d\n\n", queryNumber);
				if (searchTweetsRateLimit.getRemaining() == 0)
				{
					System.out.printf("!!! Sleeping for %d seconds due to rate limits\n", searchTweetsRateLimit.getSecondsUntilReset());
					Thread.sleep((searchTweetsRateLimit.getSecondsUntilReset()+2) * 1000l);
				}

				Query q = new Query(SEARCH_TERM);			// Search for tweets that contains this term
				q.setCount(TWEETS_PER_QUERY);				// How many tweets, max, to retrieve
				//q.ResultType.values();							// Get all tweets
				q.setLang("en");							// English language tweets, please
				if (maxID != -1)
				{
					q.setMaxId(maxID - 1);
				}
				QueryResult r = twitter.search(q);

				if (r.getTweets().size() == 0)
				{
					break;			// Nothing? We must be done
				}

				for (Status s: r.getTweets())				// Loop through all the tweets...
				{
					totalTweets++;
					if (maxID == -1 || s.getId() < maxID)
					{
						maxID = s.getId();
					}

	//				pw.println(cleanText(s.getText()));
					ps.setInt(1,totalTweets);
					ps.setString(2,args);
					ps.setString(3,s.getUser().getScreenName());
					ps.setString(4,cleanText(s.getText()));
					ps.setDouble(5,0.0);
					ps.setDouble(6,0.0);
					ps.setString(7,"non");
					try{

						v.add((count++)+")	"+s.getUser().getScreenName()+"	>>	"+cleanText(s.getText()));
						ps.executeUpdate();
		
						}
						catch(Exception e){}
//					pw.println("At %s, @%-20s said:  %s\n"+
//									  s.getCreatedAt().toString()+s.getUser().getScreenName()+cleanText(s.getText()));

				}
//				pw.close();
				searchTweetsRateLimit = r.getRateLimitStatus();
			}

		}
		catch (Exception e)
		{
			System.out.println("That didn't work well...wonder why?");

			e.printStackTrace();

		}

		System.out.printf("\n\nA total of %d tweets retrieved\n", totalTweets);
		return v;
    }
	public static void main(String[] args)throws Exception
	{
		main(args[0]);
	}
}