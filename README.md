# Flamework-JSON - Decode bad 'JSON' in PHP

The built-in PHP JSON decoder is very strict, and will not accept things which are fairly common in the wild:

* unquoted keys, e.g. {foo: 1}
* single-quoted strings, e.g. {"foo": 'bar'}
* escaped single quoted, e.g. {"foo": "b\'ar"}
* empty array elements, e.g. [1,,2]

This library allows you to decode JavaScript objects as if they were valid JSON.


## Usage

    include('lib_json.php');

    $obj = json_decode_loose($str);

If you're using <a href="https://github.com/exflickr/flamework">Flamework</a>, just drop lib_json.php into your <code>include</code> folder.
