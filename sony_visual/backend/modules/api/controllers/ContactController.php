<?php

namespace backend\modules\api\controllers;

use common\models\Contact;
use common\models\Location;
use common\models\About;
use common\models\Meetup;
use common\models\User;
use common\models\Venue;
use yii\filters\auth\HttpBasicAuth;
use yii\filters\VerbFilter;
use yii\web\Controller;

/**
 * Contact controller for the `api` module
 */
class ContactController extends Controller
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

        $behaviors['verbs'] = [
            'class' => VerbFilter::class,
            'actions' => [
                'index' => ['GET'],
                'save' => ['POST'],
//                'update' => ['GET', 'PUT', 'POST'],
//                'delete' => ['POST', 'DELETE'],
//                '*' => ['GET'],
            ],
        ];
        return $behaviors;
    }

    public function beforeAction($action)
    {
        $this->enableCsrfValidation = false;
        return parent::beforeAction($action);
    }

    public function actionIndex()
    {
//        $contact = new Contact();
//        $contact->fromMap();
////        echo '<pre>';
////        print_r($contact);
////        exit;
//
//        if($contact->validate() && $contact->save()){
//            return json_encode([
//                'status' =>  true,
//                'data' => null,
//                'messages' => ["Submitted successfully"]
//            ]);
//        }

        return json_encode([
            'status' =>  false,
            'data' => null,
            'messages' => ["Something went wrong!"]
        ]);
    }

    public function actionSave()
    {
        $contact = new Contact();
        $contact->fromMap();

        if($contact->validate() && $contact->save()){
            return json_encode([
                'status' =>  true,
                'data' => null,
                'messages' => ["Submitted successfully"]
            ]);
        }

        return json_encode([
            'status' =>  false,
            'data' => null,
            'messages' => ["Something went wrong!"]
        ]);
    }
}
