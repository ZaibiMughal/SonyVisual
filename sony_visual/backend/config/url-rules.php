<?php

$modules = ['api'];
foreach ($modules as $module) {
    $rules["$module"] = "$module/default/index";
    $rules["$module/<controller>/<id:\d+>"] = "$module/<controller>/index";
    $rules["$module/<controller>/<action>"] = "$module/<controller>/<action>";
    $rules["$module/<controller>/<action>/<id:\d+>"] = "$module/<controller>/<action>";
}
$rules['privacy-policy'] = "site/privacy-policy";
$rules['contact-us'] = "site/contact-us";
return $rules;
