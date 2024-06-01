<?php
$params = array_merge(
    require __DIR__ . '/../../common/config/params.php',
    require __DIR__ . '/../../common/config/params-local.php',
    require __DIR__ . '/params.php',
    require __DIR__ . '/params-local.php'
);

$rules = require_once 'url-rules.php';

return [
    'id' => 'app-backend',
    'name' => 'SonyVisual',
    'basePath' => dirname(__DIR__),
    'controllerNamespace' => 'backend\controllers',
    'bootstrap' => ['log'],
    'modules' => [
        'settings' => [
            'class' => 'backend\modules\settings\Settings',
        ],
        'api' => [
            'class' => 'backend\modules\api\api',
        ],
        'gridview' => [
            'class' => '\kartik\grid\Module',
            // enter optional module parameters below - only if you need to
            // use your own export download action or custom translation
            // message source
            // 'downloadAction' => 'gridview/export/download',
            // 'i18n' => []
        ],
        'dynagrid' => [
            'class' => '\kartik\dynagrid\Module',
            // other settings (refer documentation)
        ],

    ],
    'components' => [
        'request' => [
            'csrfParam' => '_csrf-backend',
        ],
//        'parsers' => [
//            'application/json' => 'yii\web\JsonParser',
//        ],
        'user' => [
            'identityClass' => 'common\models\User',
            'enableAutoLogin' => true,
            'identityCookie' => ['name' => '_identity-backend', 'httpOnly' => true],
        ],
        'session' => [
            // this is the name of the session cookie used for login on the backend
            'name' => 'advanced-backend',
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],

        'urlManager' => [
            'enablePrettyUrl' => true,
            'showScriptName' => false,
//            'rules' => array_merge([
//                ['class' => 'yii\rest\UrlRule', 'controller' => [
//                    'api/user' => 'api/user',
//                    'POST api/user/create' => 'api/user/create'
//                ]],
//
//            ]),
//            'rules' => $rules,
            'rules' => [
                'POST site/post-data' => 'site/index',
            ],
        ],
        'assetManager' => [
            'appendTimestamp' => true,
            // to generate same paths for two servers
//            'hashCallback' => function ($path) {
//                return hash('md4', $path);
//            },
        ],
    ],
    'params' => $params,
];
