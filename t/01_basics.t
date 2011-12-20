<?
	$dir = dirname(__FILE__);
	include($dir.'/testmore.php');
	include($dir.'/../lib_json.php');

	plan(13);

	# simple stuff with no transformation
	is_deeply(json_decode_loose('[1,2]'), array(1,2));
	
	# missing values in arrays
	is_deeply(json_decode_loose('[,2]'), array(null,2));
	is_deeply(json_decode_loose('[1,]'), array(1));
	is_deeply(json_decode_loose('[1,,2]'), array(1,null,2));

	# missing values in hashes
	is_deeply(json_decode_loose('{,"a":2}'), array('a' => 2));
	is_deeply(json_decode_loose('{"a":1, , "b":2}'), array('a' => 1, 'b' => 2));
	is_deeply(json_decode_loose('{"a":1, "b":2 , }'), array('a' => 1, 'b' => 2));

	# correctly double quoted strings
	is_deeply(json_decode_loose('{"foo":"bar \' baz"}'), array("foo" => "bar ' baz"));

	# deal with single quoted strings
	is_deeply(json_decode_loose('{"foo":\'bar\'}'), array("foo" => "bar"));
	is_deeply(json_decode_loose('{"foo":\'bar \\\' baz\'}'), array("foo" => "bar ' baz"));

	# quote key names
	is_deeply(json_decode_loose('{foo:2}'), array("foo" => 2));

	# detect barewords
	is_deeply(json_decode_loose('{"foo": bar}'), array("foo" => null));
	is_deeply(json_decode_loose('{"foo": $bar_woo}'), array("foo" => null));
