xquery version "1.0-ml";

module namespace ext = "http://marklogic.com/rest-api/resource/processroleinbox";

(: import module namespace config = "http://marklogic.com/roxy/config" at "/app/config/config.xqy"; :)
import module namespace json = "http://marklogic.com/xdmp/json" at "/MarkLogic/json/json.xqy";

import module namespace cpf = "http://marklogic.com/cpf" at "/MarkLogic/cpf/cpf.xqy";
import module namespace wfu="http://marklogic.com/workflow-util" at "/app/models/workflow-util.xqy";

declare namespace roxy = "http://marklogic.com/roxy";
declare namespace wf="http://marklogic.com/workflow";


(:
 : Fetch a process inbox for the current role
 :)
declare
%roxy:params("inbox=xs:string")
function ext:get(
  $context as map:map,
  $params  as map:map
) as document-node()*
{
  let $preftype := if ("application/xml" = map:get($context,"accept-types")) then "application/xml" else "application/json"

  let $_ := xdmp:log($params)
  let $_ := xdmp:log($context)

  let $out :=
    if (fn:empty(map:get($params,"role"))) then
      <ext:readResponse><ext:outcome>FAILURE</ext:outcome><ext:message>Parameter 'role' is required.</ext:message></ext:readResponse>
    else
      <ext:readResponse><ext:outcome>SUCCESS</ext:outcome>
        {wfu:roleinbox( map:get($params,"role") )}
      </ext:readResponse>

  return
  (
    xdmp:set-response-code(200, "OK"),
    document {
      if ("application/xml" = $preftype) then
        $out
      else
        let $config := json:config("custom")
        let $cx := map:put($config, "text-value", "label" )
        let $cx := map:put($config , "camel-case", fn:true() )
        return
          json:transform-to-json($out, $config)
    }
  )
};
