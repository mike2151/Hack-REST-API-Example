// Dependancies
require_once(__DIR__.'/../vendor/hh_autoload.hh');
use type Facebook\HackRouter\{BaseRouter, HttpMethod};

/* 
 * Parsing Methods
 */

// tuple to store method and route 
newtype MethodAndPath = (HttpMethod, string);

// converts string to HttpMethod. Ex: "GET" => HttpMethod::GET
function get_http_method_from_string(string $str) : HttpMethod {
    switch ($str) {
        case "GET":
            return HttpMethod::GET;
        case "POST":
            return HttpMethod::POST;
        default:
            // get is generally treated as the default
            return HttpMethod::GET;
    }
}
// parse the server request to get the path and method 
function convert_request_to_path_and_method(array $server) : MethodAndPath {
    $method = get_http_method_from_string($server['REQUEST_METHOD']);
    $path = $server['REQUEST_URI'];
    return tuple($method, $path);
}

/*
 * Router and Routes
 */ 

type TResponder = (function(dict<string, string>):string);
// this class can have any name
final class RESTAPIRouter extends BaseRouter<TResponder> {
  <<__Override>>
  protected function getRoutes(
  ): ImmMap<HttpMethod, ImmMap<string, TResponder>> {
    return ImmMap {
      HttpMethod::GET => ImmMap {
        '/' =>
          ($_params) ==> 'Getting the home page...',
        '/example/{example_param}' =>
          ($params) ==> 'Example Page: accessing, ' . $params['example_param'],
      },
      HttpMethod::POST => ImmMap {
        '/' => ($_params) ==> 'Posting to the home page...',
      },
    };
  }
}

// runs the code

<<__EntryPoint>>
function main(): noreturn {
  $router = new RESTAPIRouter();
  $method_and_path = convert_request_to_path_and_method($_SERVER);
  try {
      list($responder, $params) = $router->routeMethodAndPath($method_and_path[0], $method_and_path[1]);
      echo $responder(dict($params));
  }
  catch (Facebook\HackRouter\NotFoundException $ex) {
      echo "Route does not exist";
  }
  exit(0);
}

