The objective of the following documentation is to provides a Facebook sharring feature to a survey developped in Qualtrics. 
In order to add this feature, you have to follow the steps bellow : 
  
  -- Initialize the facebook environnement
  1 - Go to https://developers.facebook.com/ and click on Add New App. Create your App will provide you an unique App Id (we will use it) 
  2 - In the Main page of your app, Go to the Basic section menu. There, enter the display name, the app domains, the privacy policy URL (follow instructions present on this URL to get a Privacy Policy URL: https://termsfeed.com/blog/privacy-policy-url-facebook-app/ ). Be careful to also add a platform. For our case it's a website. In this field, enter the URL so want to use. 
  	- I draw your attention to the fact that the URL you enter in the URL field should be the same as the one you added in the app domains field. If you didn't enter the same one, you'll get a "Can't load URL" error when trying to open the facebook share dialog box. 
  3 - Finally, don't forget to turn to ON the status of your app in order to allows other users to use your applciation. (Click on the green button on the top of the screen, the initial value is OFF whenyou create your app. 
  3 - At this step you have installed your facebook environement. We can now focus on the implemantation. 
  
  -- Implemantation of the facebook sharing 
  
  1 - In your survey, create the block on which you want to add the sharing feature. 
  
  2 - Click on the addJavascript button. 
  
  3 - At this point, add the following part in the addOnload function : 

 	window.fbAsyncInit = function() {    	
		FB.init({
			appId  : 'THE ID OF YOUR APP',
			autoLogAppEvents : true,
			xfbml : true,
			version : 'v3.0'
		}); 
    };

  	(function(d, s, id){
    	var js, fjs = d.getElementsByTagName(s)[0];
     	if (d.getElementById(id)) {return;}
     	js = d.createElement(s); js.id = id;
     	js.src = "https://connect.facebook.net/en_US/sdk.js";
     	fjs.parentNode.insertBefore(js, fjs);
   	}(document, 'script', 'facebook-jssdk'));
    
   4 - You can now add the followwing code which will allow you to open a Facebook Sharer window.
      
      FB.ui({
        method: 'share',
        href: LINK YOU WANT TO SHARE,
      }, function(response){});
      
  5 -  ONE IMPORTANT THING TO KEEP IN MIND TO AVOID PROBLEM : THE CODE OF THE PART 3 AND THE PART 4 CAN'T BE WRITTEN IN THE SAME FUNCTION. IF YOU WANT TO OPEN THE FACEBOOK SHARER AFTER A BUTTON CLICK, HERE AN EXAMPLE THAT DEMONSTRATE HOW TO DO IT : 
      
      Qualtrics.SurveyEngine.addOnload(function()
    {
      /*Place your JavaScript here to run when the page loads*/
        
      //Initialization of the Facebook SHarer Window 
      window.fbAsyncInit = function() {    	
        FB.init({
          appId  : YOUR APP ID, 
          autoLogAppEvents : true,
          xfbml : true,
          version : 'v3.0'
        });
        };

  	(function(d, s, id){
    	var js, fjs = d.getElementsByTagName(s)[0];
     	if (d.getElementById(id)) {return;}
     	js = d.createElement(s); js.id = id;
     	js.src = "https://connect.facebook.net/en_US/sdk.js";
     	fjs.parentNode.insertBefore(js, fjs);
   	}(document, 'script', 'facebook-jssdk'));
	
    this.questionclick = function(){

        FB.ui({
        method: 'share',
        quote:  YOUR TEXT,
        href : YOUR HREF,
      }, function(response){});
    }
    });
    
   6 - At this point, your survey should now integrate the facebook sharing feature.  

   EXTRA POINT : 
  
   1 - If you want to use values collected in your survey, a way to do it proprely, you should consider to use Embedded Data. Here how to use Embedded Data : 

    	Qualtrics.SurveyEngine.setEmbeddedData( 'Score_Anxiete', "VALUE OF YOUR SURVEY THAT U CAN GET VIA THE PIPED TEXT PATH" );
	var score_anxi = Qualtrics.SurveyEngine.getEmbeddedData('Score_Anxiete') ;
  
  Here, Qualtrics.SurveyEngine.setEmbeddedData is going to affect the value you want to save in the EmbeddedData. And to use it after, you just have to call the getEmbeddedData method which will return the value of the variable you gave in parameter. It is important in order to use those two methods to create the EmbeddedData. To Do that, click on the "Survey Flow" item (it's on the top of the page). And after you cliked on item, click on "Add Below" and "EmbeddedData". Create your variable and click on Move to place this green block on the top of your Flow. That's it, you have created an Embedded Data, you can use to save variable values. 
  
  2 - If you want to add a Twitter SHaring feature, click on Add Javascript like for the facebook sharing. And add the following rows : 
  
  	// Opens a pop-up with twitter sharing dialog
      	var shareURL = "http://twitter.com/share?"; //url base
      	//params
	var params = {
		url: "URL YOU WANT TO SHARE ", 
		text: TEXT YOU WANT ,
		via: "sometwitterusername",
		hashtags: "hashtag1,hashtag2"
	}
     	for(var prop in params) shareURL += '&' + prop + '=' + encodeURIComponent(params[prop]);
      	window.open(shareURL, '', 'left=0,top=0,width=550,height=450,personalbar=0,toolbar=0,scrollbars=0,resizable=0');
