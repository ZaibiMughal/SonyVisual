<?php

namespace backend\modules\api\controllers;

use common\models\About;
use common\models\User;
use yii\filters\auth\HttpBasicAuth;
use yii\web\Controller;

/**
 * About controller for the `api` module
 */
class AboutController extends Controller
{
    /**
     * Renders the index view for the module
     * @return array[]
     */

    public function behaviors()
    {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBasicAuth::class,
            'auth' => function ($username, $password) {
            if($username == User::APP_USERNAME && $password == User::APP_PASSWORD){
                return User::find()->one();
            }
            return null;
        }
        ];
        return $behaviors;
    }

    public function actionIndex($id = 0)
    {
        $about = About::find()->one();

        return json_encode([
            'status' => true,
            'data' => $about == null ? null : $about->toMap(),
            'messages' => $about != null ? ['Success'] : ['No about content found!']
        ]);
    }
}
