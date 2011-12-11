<?
	require_once(dirname(__FILE__) . '/simpletest/autorun.php');

	include('lib_json.php');


	#
	# let the tests begin!
	#

	class JSONLooseTests extends UnitTestCase {

		function testStuff(){

			# simple stuff with no transformation
			$this->checkDeep('[1,2]', array(1,2));

			# missing values in arrays
			$this->checkDeep('[,2]', array(null,2));
			$this->checkDeep('[1,]', array(1));
			$this->checkDeep('[1,,2]', array(1,null,2));

			# missing values in hashes
			$this->checkDeep('{,"a":2}', array('a' => 2));
			$this->checkDeep('{"a":1, , "b":2}', array('a' => 1, 'b' => 2));
			$this->checkDeep('{"a":1, "b":2 , }', array('a' => 1, 'b' => 2));

			# correctly double quoted strings
			$this->checkDeep('{"foo":"bar \' baz"}', array("foo" => "bar ' baz"));

			# deal with single quoted strings
			$this->checkDeep('{"foo":\'bar\'}', array("foo" => "bar"));
			$this->checkDeep('{"foo":\'bar \\\' baz\'}', array("foo" => "bar ' baz"));

			# quote key names
			$this->checkDeep('{foo:2}', array("foo" => 2));
		}

		function checkDeep($json, $target){
			$got = serialize(json_decode_loose($json));
			$expect = serialize($target);
			$this->assertEqual($got, $expect);
		}
	}

