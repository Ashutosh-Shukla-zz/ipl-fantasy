package com.ipl.util;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

import com.ipl.bean.StaticData.PlayerBean;
import com.ipl.bean.StaticData.StaticDataBean;
import com.ipl.bean.StaticData.TeamBean;
import com.ipl.controller.StaticDataController;

public class MatchResultData {

  private static String readAll(Reader rd) throws IOException {
    StringBuilder sb = new StringBuilder();
    int cp;
    while ((cp = rd.read()) != -1) {
      sb.append((char) cp);
    }
    return sb.toString();
  }

  public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
    InputStream is = new URL(url).openStream();
    try {
      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
      String jsonText = readAll(rd);
      jsonText.length();
      jsonText = jsonText.substring(10, jsonText.length());
      jsonText = jsonText.substring(0, jsonText.length()-2);
      JSONObject json = new JSONObject(jsonText);
      return json;
    } finally {
      is.close();
    }
  }

  public  HashMap<String, JsonPlayerMap> getMatchResultData(String matchId) throws IOException, JSONException {
      if(Integer.parseInt(matchId)<10){
          matchId = "0"+matchId;
      }
      
    JSONObject json = readJsonFromUrl("http://datacdn.iplt20.com/dynamic/data/core/cricket/2012/ipl2018/ipl2018-"+matchId+"/scoring.js");
    
    
    System.out.println(json.toString());
    
   HashMap<String, JsonPlayerMap> playerScoreMap = new HashMap<>();
    
  
   String team0= json.getJSONObject("matchInfo").getJSONArray("teams").getJSONObject(0).getJSONObject("team").getString("fullName");
   
   String team1= json.getJSONObject("matchInfo").getJSONArray("teams").getJSONObject(1).getJSONObject("team").getString("fullName");
   
   StaticDataBean sdb = StaticDataController.getStaticDataBean();
   
   TeamBean teamBean1 = new TeamBean();
   TeamBean teamBean2 = new TeamBean();
   
   for(TeamBean team: sdb.getTeamBean()){
       if(team.getTeamName().equalsIgnoreCase(team0)){
           teamBean1 = team;
       }
       if(team.getTeamName().equalsIgnoreCase(team1)){
           teamBean2 = team;
       }
   }
   
   for(PlayerBean players:teamBean1.getPlayerBean()){
       JsonPlayerMap playerScore = new JsonPlayerMap();
       playerScore.setPlayerId(players.getPlayerId());
       playerScoreMap.put(players.getFirstName()+ " " +players.getLastName(),playerScore);
   }
   
   for(PlayerBean players:teamBean2.getPlayerBean()){
       JsonPlayerMap playerScore = new JsonPlayerMap();
       playerScore.setPlayerId(players.getPlayerId());
       playerScoreMap.put(players.getFirstName()+ " " +players.getLastName(), playerScore);
   }
       
   
   for(int i=0;i< json.getJSONArray("innings").length();i++){
       for(int j=0;j<json.getJSONArray("innings").getJSONObject(i).getJSONObject("scorecard").getJSONArray("battingStats").length();j++){
           JSONObject playerObject = json.getJSONArray("innings").getJSONObject(i).getJSONObject("scorecard").getJSONArray("battingStats").getJSONObject(j);

           //runs
           String playerName = getRemotePlayerName(json,playerObject.getInt("playerId"));
           if(playerScoreMap.get(playerName)!=null)
           playerScoreMap.get(playerName).setRuns(playerObject.getInt("r"));
           
           
           //catchOut
           
           if(playerObject.has("mod") && !playerObject.isNull("mod")){
               if(playerObject.getJSONObject("mod").getString("dismissedMethod").equalsIgnoreCase("ct")){
                   if(playerObject.getJSONObject("mod").has(("additionalPlayerIds")))
                   {String catchOutPlayerName = getRemotePlayerName(json,playerObject.getJSONObject("mod").getJSONArray("additionalPlayerIds").getInt(0));
                   int prevCatch =  playerScoreMap.get(catchOutPlayerName).getCatches();
                   if(playerScoreMap.get(playerName)!=null)
                   playerScoreMap.get(catchOutPlayerName).setCatches(prevCatch+1);}
               }
           }
           
           //runout
           
           if(playerObject.has("mod") && !playerObject.isNull("mod")){
               if(playerObject.getJSONObject("mod").getString("dismissedMethod").equalsIgnoreCase("ro")){
                   if(playerObject.getJSONObject("mod").has(("additionalPlayerIds")))
                   {
                   String runOutPlayerName = getRemotePlayerName(json,playerObject.getJSONObject("mod").getJSONArray("additionalPlayerIds").getInt(0));
                   int runOuts =  playerScoreMap.get(runOutPlayerName).getRunOuts();
                   if(playerScoreMap.get(playerName)!=null)
                   playerScoreMap.get(runOutPlayerName).setCatches(runOuts+1);
                   }
               }
           }
           
           //stumping
           if(playerObject.has("mod") && !playerObject.isNull("mod")){
               if(playerObject.getJSONObject("mod").getString("dismissedMethod").equalsIgnoreCase("st")){
                   if(playerObject.getJSONObject("mod").has(("additionalPlayerIds")))
                   {
                   String stumpingPlayerName = getRemotePlayerName(json,playerObject.getJSONObject("mod").getJSONArray("additionalPlayerIds").getInt(0));
                   int stumps =  playerScoreMap.get(stumpingPlayerName).getStumping();
                   if(playerScoreMap.get(playerName)!=null)
                   playerScoreMap.get(stumpingPlayerName).setStumping(stumps+1);
                   }
               }
           }
           
       }
       
       //Wickets
       for(int k=0;k<json.getJSONArray("innings").getJSONObject(i).getJSONObject("scorecard").getJSONArray("bowlingStats").length();k++){
           JSONObject playerObject = json.getJSONArray("innings").getJSONObject(i).getJSONObject("scorecard").getJSONArray("bowlingStats").getJSONObject(k);
           String playerName = getRemotePlayerName(json,playerObject.getInt("playerId"));
           if(playerScoreMap.get(playerName)!=null)
           playerScoreMap.get(playerName).setWickets(playerObject.getInt("w"));
       }
   }
   
   //mom
   if(!json.getJSONObject("matchInfo").getJSONObject("additionalInfo").isNull("result.playerofthematch")){
	   if((null!=json.getJSONObject("matchInfo").getJSONObject("additionalInfo").getString("result.playerofthematch")) && (!"".equalsIgnoreCase(json.getJSONObject("matchInfo").getJSONObject("additionalInfo").getString("result.playerofthematch"))))
		   playerScoreMap.get(json.getJSONObject("matchInfo").getJSONObject("additionalInfo").getString("result.playerofthematch")).setIsMom(Boolean.TRUE);
   }
   
   
   
   
   System.out.println(team0);
   System.out.println(team1);
   return playerScoreMap;
  }
  
  private String getRemotePlayerName(JSONObject json, int playerId){
      String playerName=null;
      try
    {
        for(int i=0;i< json.getJSONObject("matchInfo").getJSONArray("teams").length();i++){
                for(int j = 0;j<json.getJSONObject("matchInfo").getJSONArray("teams").getJSONObject(i).getJSONArray("players").length();j++){
                    if(json.getJSONObject("matchInfo").getJSONArray("teams").getJSONObject(i).getJSONArray("players").getJSONObject(j).getInt("id")==playerId){
                        return json.getJSONObject("matchInfo").getJSONArray("teams").getJSONObject(i).getJSONArray("players").getJSONObject(j).getString("fullName").replace("'", " ");
                    }
                }
          }
    }
    catch (JSONException e)
    {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
      
    return playerName;
      
  }
}