<?php include "library/twitteroauth.php"; ?>
<?php
	$consumer = "NRfvURBas1Rr4pW9FCYXPlMa3";
	$consumersecret = "YSskWJlgZw1uai9PxpJwJ11rddRIEpOQ8CdbkodkZKXmn820lF";
	$accesstoken = "69014652-vvtzyNWRorejiSo4Y3X9ezvqk0viXZtqoXDoTvTbv";
	$accesstokensecret = "VcX1Hzqsjortt90kSkoYnuooXJ3dfZ4bPYUpXhCGspig3";

$twitter = new TwitterOAuth($consumer,$consumersecret,$accesstoken,$accesstokensecret);

$tweets = $twitter->get('https://api.twitter.com/1.1/search/tweets.json?q=php&result_type=mixed&count=10')

?>

<html>
	<head>
		<meta charset="UTF-8" />
		<title>Shubhanshu Gupta | Tweet Fetcher</title>
	</head>

	<body>
		<form action="" method="post">
		<label>Search: <input type="text" name="keyword"/></label>
		</form>
		<?php 
		if(isset($_POST['keyword'])){
			$tweets = $twitter->get('https://api.twitter.com/1.1/search/tweets.json?q='.$_POST['keyword'].'&geocode=28.6100,77.2300,1mi&lang=en&result_type=mixed&count=100');
			foreach ($tweets as $tweet) {
							# code...
							foreach ($tweet as $t) {
								# code...
									echo '<img src="'.$t->user->profile_image_url.'" />'.$t->text;
									echo "<br>";
							}
						

						}			
		}
		?>
	</body>

</html>
