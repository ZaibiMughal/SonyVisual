<?php

namespace backend\modules\api\controllers;

use common\models\About;
use common\models\APIResponse;
use common\models\LoginForm;
use common\models\User;
use common\models\VideoPost;
use frontend\models\SignupForm;
use Yii;
use yii\base\Exception;
use yii\filters\auth\HttpBasicAuth;
use yii\filters\VerbFilter;
use yii\rest\ActiveController;
use yii\web\Controller;
use yii\web\UploadedFile;

/**
 * About controller for the `api` module
 */
class UserController extends BaseController
{
    public $modelClass = 'common\models\User';
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
            'class' => VerbFilter::className(),
            'actions' => [
                'create' => ['GET','POST'],
                'update' => ['GET', 'PUT', 'POST'],
                'delete' => ['GET','POST', 'DELETE'],
                'index' => ['GET','POST'],
                'login' => ['GET','POST'],
            ],
        ];
        return $behaviors;
    }

    public function beforeAction($action)
    {
        return parent::beforeAction($action); // TODO: Change the autogenerated stub
    }

    public function actionIndex($id = 0)
    {
        $user_id = $id ?? \Yii::$app->request->post('user_id',0);

        if($user_id) {
            try {
                $user = User::findOne(['id' => $user_id]);
                Yii::$app->response->statusCode = 200;
                return [
                    'status' => true,
                    'data' => is_null($user) ? null : $user->toMap(),
                    'messages' => is_null($user) ? ['No about content found!'] : ['Success']
                ];
            } catch (Exception $e){
                Yii::$app->response->statusCode = 500;
                return [
                    'status' => false,
                    'data' => null,
                    'messages' => ['Something went wrong!']
                ];
            }
        }

        Yii::$app->response->statusCode = 422;
        return [
            'status' => false,
            'data' => null,
            'messages' => ['Something went wrong!']
        ];
    }

    public function actionCreate()
    {
        $first_name = Yii::$app->request->post('first_name','');
        $last_name = Yii::$app->request->post('last_name','');
        $email = Yii::$app->request->post('email','');
        $password = Yii::$app->request->post('password','');

        $user = new User(['scenario' => 'register']);
        $user->updated_by = \Yii::$app->user->id;
        $user->first_name = $first_name;
        $user->last_name = $last_name;
        $user->email = $email;
        $user->password = $password;
        $user->generateHiddenAttributes();
        $user->updated_at = time();

        try {

            $user->imageFile = UploadedFile::getInstanceByName('uploaded_file');
            if ($user->validate()) {
                $user->uploadThumbnail();
                $user->save(false);

                Yii::$app->response->statusCode = 200;
                return [
                    'status' => true,
                    'data' => $user->toMap(),
                    'messages' => ['Success']
                ];
            } else {
                Yii::$app->response->statusCode = 422;
                return [
                    'status' => false,
                    'data' => null,
                    'messages' => $user->getErrorSummary(true)
                ];
            }
        } catch (Exception $e){
            Yii::$app->response->statusCode = 422;
            return [
                'status' => false,
                'data' => null,
                'messages' => ['Something went wrong!']
            ];
        }
    }

    public function actionUpdate()
    {
        $first_name = Yii::$app->request->post('first_name',null);
        $last_name = Yii::$app->request->post('last_name',null);
        $user_id = Yii::$app->request->post('user_id','');

        try {
            $user = User::findOne($user_id);

            if($user){
                $user->first_name = $first_name ?? $user->first_name;
                $user->last_name = $last_name ?? $user->last_name;
                $user->updated_at = time();

                $user->imageFile = UploadedFile::getInstanceByName('uploaded_file');

                if ($user->validate()) {

                    $user->uploadThumbnail();
                    $user->save(false);

                    Yii::$app->response->statusCode = 200;
                    return [
                        'status' => true,
                        'data' => $user->toMap(),
                        'messages' => ['Success']
                    ];
                } else {
                    Yii::$app->response->statusCode = 422;
                    return [
                        'status' => false,
                        'data' => null,
                        'messages' => $user->getErrorSummary(true)
                    ];
                }
            } else {
                Yii::$app->response->statusCode = 404;
                return [
                    'status' => false,
                    'data' => null,
                    'messages' => ['User not found!']
                ];
            }
        } catch (Exception $e){
            Yii::$app->response->statusCode = 422;
            return [
                'status' => false,
                'data' => null,
                'messages' => ['Something went wrong!']
            ];
        }

    }

    public function actionLogin()
    {
        $email = Yii::$app->request->get('email','');
        $password = Yii::$app->request->get('password','');

        $model = new LoginForm();
        $model->email = $email;
        $model->password = $password;
        try {
            if ($model->validate() && $model->login()) {
                $user = User::findCompanyUser($email);
                Yii::$app->response->statusCode = 200;
                return [
                    'status' => true,
                    'data' => $user->toMap(),
                    'messages' => ['Success']
                ];
            } else {
                Yii::$app->response->statusCode = 401;
                return [
                    'status' => false,
                    'data' => null,
                    'messages' => ['Email or Password is wrong!']
                ];
            }
        } catch (Exception $e){
            Yii::$app->response->statusCode = 422;
            return [
                'status' => false,
                'data' => null,
                'messages' => ['Something went wrong!']
            ];
        }
    }


    public function actionDelete()
    {
        $message = "";
        $data = "";
        $status = false;
        $id = Yii::$app->request->get('id','');
        try{

            $model = User::findOne($id);
            if($model){
                if($model->isSuperAdmin()){
                    $message = "Can't delete the Super Admin";
                    Yii::$app->response->statusCode = 422;
                } else {
                    // Need to delete all of its videos as well
                    VideoPost::deleteAll(['user_id' => $id]);
                    $model->delete();
                    Yii::$app->response->statusCode = 200;
                    $status = true;
                }
            } else {
                $message = "User not found";
                Yii::$app->response->statusCode = 404;
            }
        } catch (\yii\base\Exception $e){
            $message = "Can't delete this record as it is being referenced in other Data / Table";
            Yii::$app->response->statusCode = 422;
        }

        return [
            'status' => $status,
            'data' => null,
            'messages' => [$message]
        ];
    }
}
